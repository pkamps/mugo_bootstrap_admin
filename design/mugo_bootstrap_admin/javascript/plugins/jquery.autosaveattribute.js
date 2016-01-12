;(function ( $, window, document, undefined )
{
    var pluginName = 'autosaveattribute',
        pluginElement = null,
        defaults =
        {
            baseUrl : '',
            getData : null,
            initTrigger: null,
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

            self.initTrigger();
        },

        save : function( content )
        {
            var self = this;

            var data = content || self.getData();

            var formData = new FormData();

            formData.append( 'attribute_id', $(this.element).attr( 'data-id' ) );
            formData.append( 'version_id', $(this.element).attr( 'data-version-nr' ) );
            formData.append( 'data', data );
            formData.append( 'ezxform_token', $( '#ezxform_token_js' ).attr( 'content' ) );

            $.ajax(
                {
                    url: self.options.baseUrl + '/mugo_bootstrap_admin/store_attribute',
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
                        self.afterUpload( data );
                    },
                    error: function( data )
                    {
                        alert( 'Failed to store data.' );
                    },
                });
        },

        getData : function()
        {
            var self = this;

            if( typeof self.options.getData === 'function' )
            {
                return self.options.getData();
            }
            else
            {
                return $(self.element).val();
            }
        },

        initTrigger : function()
        {
            var self = this;

            if( typeof self.options.initTrigger === 'function' )
            {
                return self.options.initTrigger( self );
            }
            else
            {
                $(self.element).change(function()
                {
                    self.save();
                });
            }
        },

        afterUpload : function( data )
        {
            var self = this;

            $( self.element ).attr( 'data-dirty', 0 );

            //console.log( data );
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