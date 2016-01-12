;(function ( $, window, document, undefined )
{
    var pluginName = 'editobjectrelationlist',
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

			// make table it an autosave attribute
            $(self.element).find( '.nodes-table' ).autosaveattribute(
			{
				baseUrl: self.options.baseUrl,
				initTrigger: function( plugin )
				{
					$(plugin.element).bind( 'DOMSubtreeModified propertychange', function()
					{
						console.log( 'dirty' );
					});
				},
			});

            self.initTriggers();
        },

        initTriggers : function()
        {
            var self = this;

			// add marked entries click
            $( self.element ).find( '.add-marked' ).click( function()
            {
                var currentTree = $( '.tree:visible' );

                if( currentTree.length )
                {
                    var nodes = $( '.tree:visible' ).treemenu( 'getSelectedNodes' );

                    if( nodes.length )
                    {
                        var target = $(self.element).find( 'table' );
                        var templateElement = $(self.element).find( 'tr.template' )[0];

                        var row;
                        $.each( nodes, function()
                        {
                            row = self.renderTemplate( templateElement, this, true );
                            target.append( $(row).removeClass( 'template' ) );
                        });
                    }
                }
            });

			// remove marked click
			$( self.element ).find( '.remove-marked' ).click( function()
			{
				$.each( $(self.element).find( '.nodes-table input:checked[type="checkbox"]' ), function()
				{
					$(this).closest( 'tr' ).fadeOut(400, function()
					{
						$(this).remove();
					});
				});
			});
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