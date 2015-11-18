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

			self.loadList( $( self.element ).find( 'li.container' ), false );
		},

		loadList : function( containerTag, force )
		{
			var self = this;
			var data = localStorage.getItem( getCacheKey( containerTag ) );

			if( !data || force )
			{
				console.log( 'server hit' );
				var url =
						self.options.baseUrl +
						'mugo_bootstrap_admin/treemenu_list/' +
						containerTag.attr( 'data-node-id' );

				$.get( url, function( data )
				{
					localStorage.setItem( getCacheKey( containerTag ), cleanData( data ) );
					containerTag.append( localStorage.getItem( getCacheKey( containerTag ) ) );
					self.handleListResult( containerTag );
				});
			}
			else
			{
				containerTag.append( localStorage.getItem( getCacheKey( containerTag ) ) );
				self.handleListResult( containerTag );
			}
		},

		handleListResult : function( containerTag )
		{
			var self = this;

			var children = containerTag.find( '> ul > li' );

			$.each( children, function()
			{
				var child = this;

				if( $(child).hasClass( 'container' ) )
				{
					// Add click event
					$(child).find( '> span' ).on( 'click', function(e)
					{
						var subContainerTag = $(this).parent( 'li.container' );

						var subChildren = subContainerTag.find( '> ul > li' );

						if( !subChildren.length )
						{
							self.loadList( subContainerTag, false );
						}
						else
						{
							subChildren.toggle( 'fast', function()
							{
								localStorage.removeItem( getCacheKey( $(child) ) );
							});
						}

						return false;
					});

					// Is open
					if( localStorage.getItem( getCacheKey( $(child) ) ) !== null )
					{
						self.loadList( $(child), false );
					}
				}
			});
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
