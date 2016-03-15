;(function ( $, window, document, undefined )
{
    var pluginName = 'ezcontextmenu',
        pluginElement = null,
        defaults =
        {
            baseUrl : '',
            data: null,
        };

    // Run once
    // TODO: is that expensive?
    $('body').on('click', function (e)
    {
        $('[data-toggle="contextmenu"]').each(function ()
        {
            //the 'is' for buttons that trigger popups
            //the 'has' for icons within a button that triggers a popup
            if(
                $(this).attr( 'aria-describedby' ) &&
                !$(this).is(e.target) &&
                $(this).has(e.target).length === 0 &&
                $('.mugo-context-menu').has(e.target).length === 0
            )
            {
                $(this)
                    .popover( 'hide' )
                    // workaround for https://github.com/twbs/bootstrap/issues/16732
                    .data( 'bs.popover' ).inState.click = false;
            }
        });
    });

    function cleanData( data )
    {
        return data.replace( /\<div id="debug"[\s\S]*div\>/i, '' );
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

            $( this.element ).popover(
            {
                container: 'body',
                content: function()
                {
                    var html = $( '#contextmenu-content' ).html();

                    Mustache.parse( html, [ '[[', ']]' ] );

                    return Mustache.render( html, self.getData() );
                },
                html: true,
                placement: 'auto top',
                title: function()
                {
                    var titleFunction = this;

                    if( titleFunction.cache ) return titleFunction.cache;

                    var div_id = 'tmp-id-' + $.now();
                    var data = self.getData();

                    if( data.node_id )
                    {
                        $.ajax(
                        {
                            url: self.options.baseUrl + '/mugo_bootstrap_admin/node_view_gui?view=mini&node_id=' + data.node_id,
                            success: function( response )
                            {
                                titleFunction.cache = cleanData( response );
                                $( '#'+div_id ).html( titleFunction.cache );
                            }
                        });
                    }

                    titleFunction.cache = '<div id="'+ div_id +'">Loading...</div>';
                    return titleFunction.cache;
                },
            })
            .data( 'bs.popover' )
            .tip()
            .addClass( 'mugo-context-menu' );
        },

        show : function()
        {
            var self = this;
            $( self.element ).popover( 'show' );
        },

        renderTemplate : function( element, vars, parse )
        {
            if( element )
            {
                var template = element.outerHTML;

                if( parse )
                {
                    Mustache.parse( element.outerHTML, [ '[[', ']]' ] );
                }

                return Mustache.render( template, vars );
            }

            return '';
        },

        getData : function()
        {
            var self = this;

            if( self.options.data )
            {
                return self.options.data;
            }
            else
            {
                var context = $( self.element ).closest( '[data-node_id]' );

                var vars =
                {
                    node_id : parseInt( context.attr( 'data-node_id' ) ),
                    contentobject_id : parseInt( context.attr( 'data-contentobject_id' ) ),
                };

                return vars;
            }
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