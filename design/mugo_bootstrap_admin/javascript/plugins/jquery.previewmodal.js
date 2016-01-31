;(function ( $, window, document, undefined )
{
    var pluginName = 'previewmodal',
        pluginElement = null,
        defaults =
        {
            targetVars:
            {
                nodeId : null,
                contentObjectId: null,
                nodeUrl: null,
                versionNumber: null,
            },
        };

    function getScrollBarWidth()
    {
        // Create the measurement node
        var scrollDiv = document.createElement("div");
        scrollDiv.className = "scrollbar-measure";
        document.body.appendChild(scrollDiv);

        // Get the scrollbar width
        var scrollbarWidth = scrollDiv.offsetWidth - scrollDiv.clientWidth;
        console.warn(scrollbarWidth); // Mac:  15

        // Delete the DIV
        document.body.removeChild(scrollDiv);
    }

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

            $( self.element ).modal(
            {
                backdrop: true,
                show: false,
            });

            self.initTriggers();
        },

        initTriggers : function()
        {
            var self = this;
            var iframe = $(self.element).find( 'iframe' );

            iframe.load( function()
            {
                $(this).show();
            });

            $( '#preview-selector' ).change( function()
            {

                iframe
                    .hide()
                    .attr( 'src', self.parseUrl( $(this).find( 'option:selected' ).attr( 'data-iframe-target' ) ) );

                var defaultSize = $(this).find( 'option:selected' ).attr( 'data-default-size' );
                if( defaultSize )
                {
                    $( self.element ).find( '#preview-size' )
                        .val( defaultSize )
                        .change();
                }
            });

            $( self.element ).find( '#preview-size' ).change( function()
            {
                $( self.element ).find( '#iframe-wrapper' )
                    .removeClass( 'extra-small-width small-width medium-width large-width' )
                    .addClass( $(this).val() );
            });

            $( self.element ).find( '#open-in-new-window' ).click( function()
            {
                window.open( $(self.element).find( 'iframe').attr( 'src' ) );
            });

            // TODO: not sure if that's the right place for it
            $( '#view-button *[data-layout]' ).click( function()
            {
                self.show( $(this).attr( 'data-layout' ) );
                return false;
            });
        },

        show : function( layout )
        {
            var self = this;

            $( '#preview-selector' )
                .val( layout )
                .change();

            $(self.element).modal( 'show' );
        },

        parseUrl : function( url )
        {
            var self = this;


            Mustache.parse( url, [ '[[', ']]' ] );

            return Mustache.render( url, self.options.targetVars );
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