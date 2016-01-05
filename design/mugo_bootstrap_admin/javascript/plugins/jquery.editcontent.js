;(function ( $, window, document, undefined )
{
    var pluginName = 'editcontent',
        pluginElement = null,
        defaults =
        {
            baseUrl : '',
        };

    function Plugin( element, options )
    {
        pluginElement = element;
        this.element = element;
        this.options = $.extend( {}, defaults, options) ;
        this._defaults = defaults;
        this._name = pluginName;

        this.init();
    }

    Plugin.prototype =
    {
        init : function()
        {
            var self = this;

            self.initTriggers();
        },

        initTriggers : function()
        {
            var self = this;

            $( '#publish-button').click( function()
            {
                $.ajax(
                {
                    url: self.options.baseUrl + '/mugo_bootstrap_admin/publish',
                    type: 'POST',
                    // Form data
                    data: self.getFormData(),
                    dataType: 'json',
                    //Options to tell jQuery not to process data or worry about content-type.
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function( data )
                    {
                        self.afterPublish( data );
                    },
                    error: function( data )
                    {
                        alert( 'Failed to publish data.' );
                    },
                });
            });

            $( '#discard-button' ).click( function()
            {
                var formData = new FormData();

                formData.append( 'contentobjectid', $( self.element ).attr( 'data-contentobject-id' ) );
                formData.append( 'versionnr', $( self.element ).attr( 'data-version-nr' ) );

                $.ajax(
                {
                    url: self.options.baseUrl + '/mugo_bootstrap_admin/discard',
                    type: 'POST',
                    // Form data
                    data: formData,
                    dataType: 'json',
                    //Options to tell jQuery not to process data or worry about content-type.
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function( data )
                    {
                        self.afterPublish( data );
                    },
                    error: function( data )
                    {
                        alert( 'Failed to publish data.' );
                    },
                });
            });
        },

        afterPublish : function( data )
        {
            var self = this;

            location.href = self.options.baseUrl + '/' + data.target;
        },

        getFormData : function()
        {
            var self = this;

            var formData = new FormData();

            $.each( $( '*[data-version-id]' ), function()
            {
                formData.append( 'versionids[]', $(this).attr( 'data-version-id' ) );
            });

            return formData;
        },
    };

    $.fn[pluginName] = function ( options ) {
        var args = arguments;

        if (options === undefined || typeof options === 'object') {
            return this.each(function ()
            {
                if (!$.data(this, 'plugin_' + pluginName)) {

                    $.data(this, 'plugin_' + pluginName, new Plugin( this, options ));
                }
            });

        } else if (typeof options === 'string' && options[0] !== '_' && options !== 'init') {

            var returns;

            this.each(function () {
                var instance = $.data(this, 'plugin_' + pluginName);

                if (instance instanceof Plugin && typeof instance[options] === 'function') {

                    returns = instance[options].apply( instance, Array.prototype.slice.call( args, 1 ) );
                }

                // Allow instances to be destroyed via the 'destroy' method
                if (options === 'destroy') {
                    $.data(this, 'plugin_' + pluginName, null);
                }
            });

            return returns !== undefined ? returns : this;
        }
    };

}(jQuery, window, document));