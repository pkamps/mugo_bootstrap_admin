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

			self.loadList( $( self.element ).find( 'li.container' ) );
		},

		/**
		 *
		 * @param containerTag
         * @param force
         */
		loadList : function( containerTag )
		{
			var self = this;
			var data = localStorage.getItem( self.getUrl( containerTag ) );

			if( !data )
			{
				var url = self.getUrl( containerTag );

				$.get( url, function( response )
				{
					data = cleanData( response );
					localStorage.setItem( url, data );
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
						var subChildren = subContainerTag.find( '> ul' );

						// Load and show
						if( !subChildren.length )
						{
							self.loadList( subContainerTag );
						}
						// Unload and hide
						else
						{
							subChildren.hide( 'fast' );
							subChildren.remove();
							localStorage.removeItem( self.getUrl( $(child) ) );
						}

						return false;
					});

					// Is open
					if( localStorage.getItem( self.getUrl( $(child) ) ) !== null )
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
					contentObjectId: $(this).attr( 'data-contentobject-id' ),
					name: $(this).find('> a').text(),
					className: 'Image',
				});
			});

			return result;
		},

		getUrl : function( containerTag )
		{
			var self = this;

			var type = containerTag.attr( 'data-type' ) || 'node_id';

			return self.options.baseUrl + '/mugo_bootstrap_admin/treemenu_list/' + containerTag.attr( 'data-value' ) +  '/' + type;
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
