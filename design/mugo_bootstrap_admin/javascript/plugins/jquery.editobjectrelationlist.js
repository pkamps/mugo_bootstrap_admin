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
        contentTable : null,

        init : function()
        {
            var self = this;

            self.contentTable = $(self.element).find( '.nodes-table' );

			// make table it an autosave attribute
            self.contentTable.autosaveattribute(
			{
				baseUrl: self.options.baseUrl,
                attributeId: parseInt( $(this.element).attr( 'data-id' ) ),
                versionNr: parseInt( $(this.element).attr( 'data-version-nr' ) ),
				initTrigger: function( plugin )
				{
					$(plugin.element).find( 'tbody' ).bind( 'DOMSubtreeModified propertychange', function()
					{
                        $(plugin.element).autosaveattribute( 'save' );
					});
				},
                getData : function( plugin )
                {
                    var contentObjectIds = [];
                    var contentObjectId;

                    $.each( $(plugin.element).find( 'tbody tr:visible' ), function()
                    {
                        contentObjectId = parseInt( $(this).attr( 'data-contentobject_id' ) );
                        if( contentObjectId )
                        {
                            contentObjectIds.push( contentObjectId );
                        }
                    });

                    return contentObjectIds.join( '-' );
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
                    var nodes = currentTree.fancytree( 'getTree' ).getSelectedNodes();

                    if( nodes.length )
                    {
                        var target = $(self.element).find( 'table' );
                        var templateElement = $(self.element).find( 'tr.template' )[0];

                        var row;
                        var vars;
                        $.each( nodes, function()
                        {
                            console.log( this.data );

                            vars =
                            {
                                contentObjectId: this.data.contentobject_id,
                                name: this.data.name,
                                className: this.data.class_identifier,
                                icon: this.data.href,
                            };
                            row = self.renderTemplate( templateElement, vars, true );
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