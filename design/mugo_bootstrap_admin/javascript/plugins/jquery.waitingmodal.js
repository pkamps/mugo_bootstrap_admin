;(function ( $, window, document, undefined )
{
    var pluginName = 'waitingmodal',
        pluginElement = null,
        defaults =
        {
            baseUrl : '',
            message: 'Loading...',
            onComplete: null,
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

            //$dialog.find('.progress-bar').attr('class', 'progress-bar');
            $(self.element).find( 'h3' ).text( self.options.message );

            self.show();
        },

        show: function( message, options )
        {
            var self = this;

            // Adding callbacks
            /*
            if (typeof settings.onHide === 'function') {
                $dialog.off('hidden.bs.modal').on('hidden.bs.modal', function (e) {
                    settings.onHide.call($dialog);
                });
            }
            */
            $(self.element).modal();
        },

        progress: function( progressStyle )
        {
            var self = this;

            $(self.element).find( '.progress-bar' ).css( 'width', progressStyle );
        },

        /**
         * Closes dialog
         */
        hide: function ()
        {
            var self = this;
            $(self.element).modal( 'hide' );
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