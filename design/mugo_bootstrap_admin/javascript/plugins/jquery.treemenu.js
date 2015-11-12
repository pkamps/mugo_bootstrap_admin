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

			self.handleListResult( $( self.element ).find( 'li.container' ) );
		},

		loadList : function( containerTag )
		{
			var self = this;

			var url =
				self.options.baseUrl +
				'mugo_bootstrap_admin/treemenu_list/' +
				containerTag.attr( 'data-node-id' );

			$.get( url, function( data )
			{
				containerTag.append( cleanData( data ) );

				var children = containerTag.find( ' > ul > li' );
				self.handleListResult( children );

				containerTag.attr( 'data-loaded', '1' );
			});
		},

		handleListResult : function( children )
		{
			var self = this;

			$.each( children, function()
			{
				if( $(this).hasClass( 'container' ) )
				{
					// Add click event
					$(this).find( '> span' ).on( 'click', function(e)
					{
						var containerTag = $(this).parent( 'li.container' );

						if( !containerTag.attr( 'data-loaded' ) )
						{
							self.loadList( containerTag );
						}
						else
						{
							var children = containerTag.find( '> ul > li' );

							if( children.length )
							{
								children.toggle( 'fast' );
							}
						}

						return false;
					});

					// Is open
					if( $(this).attr( 'data-open' ) )
					{
						self.loadList( $(this) );
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
