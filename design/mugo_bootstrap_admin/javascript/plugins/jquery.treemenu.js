;(function ( $, window, document, undefined )
{
	var pluginName = 'treemenu',
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

	function getCacheKey( containerTag )
	{
		return 'tree_cache_' + containerTag.attr( 'data-node-id' );
	}

	//drops debug output
	function cleanData( data )
	{
		return data.replace( /\<div id="debug"[\s\S]*div\>/i, '' );
	}

	Plugin.prototype =
	{
		init : function()
		{
			var self = this;

			self.loadList( $( self.element ).find( 'li.container' ) );

			// hack
			$( '.add-selected' ).click( function()
			{
				var nodes = self.getSelectedNodes();
				var target = $(this).closest( '.proto-objectrelationlist' ).find( 'table' );
				var row;

				$.each( nodes, function()
				{
					row = '<tr><td></td><td>'+ this.name +'</td><td></td><td></td><td></td><td></td></tr>';
					$(row).appendTo( target );
				});
			});
		},

		/**
		 *
		 * @param containerTag
         * @param force
         */
		loadList : function( containerTag )
		{
			var self = this;
			var data = localStorage.getItem( getCacheKey( containerTag ) );

			if( !data )
			{
				var url =
						self.options.baseUrl +
						'mugo_bootstrap_admin/treemenu_list/' +
						containerTag.attr( 'data-node-id' );

				$.get( url, function( response )
				{
					data = cleanData( response );
					localStorage.setItem( getCacheKey( containerTag ), data );
					containerTag.append( data );
					self.initList( containerTag );
				});
			}
			else
			{
				containerTag.append( data );
				self.initList( containerTag );
			}
		},

		/**
		 *
		 * @param containerTag
         */
		initList : function( containerTag )
		{
			var self = this;

			var children = containerTag.find( '> ul > li' );

			$.each( children, function()
			{
				var child = this;

				self.initChild( child );
				
				if( $(child).hasClass( 'container' ) )
				{
					var subContainerTag = $(child);

					// Add click event
					$(child).find( '> span' ).on( 'click', function(e)
					{
						var subChildren = subContainerTag.find( '> ul > li' );

						// Load and show
						if( !subChildren.length )
						{
							self.loadList( subContainerTag );
						}
						// Unload and hide
						else
						{
							//TODO: remove elements form DOC?
							subChildren.hide( 'fast', function()
							{
								localStorage.removeItem( getCacheKey( $(child) ) );
							});
						}

						return false;
					});

					// Is open
					if( localStorage.getItem( getCacheKey( $(child) ) ) !== null )
					{
						self.loadList( $(child) );
					}
				}
			});
		},

		/**
		 *
		 * @param child
         */
		initChild : function( child )
		{
			$(child).bind( 'contextmenu', function(e)
			{
				$(this).toggleClass( 'bg-success' );
				return false;
			});
		},

		getSelectedNodes : function()
		{
			var self = this;

			var result = [];

			$.each( $(this.element).find( '.bg-success' ), function()
			{
				result.push(
					{
						id: 123,
						name: $(this).find('> a').text(),
						class: 'Image',
					});
			});

			return result;
		}
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
