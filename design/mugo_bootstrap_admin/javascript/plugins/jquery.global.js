;(function ( $, window, document, undefined )
{
	var pluginName = 'global',
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

			// href in data attribute
			$( 'button[data-href]' ).click(function()
			{
				location.href = $(this).attr( 'data-href' );
			});

			// popovers
			$( '[data-toggle=popover]' ).popover();

			// remember tab
			//$( 'nav-tabs' )

			self.init_full_view();
		},

		init_full_view : function()
		{
			var self = this;

			// Create new button
			$( '[data-handle="createnew"]' ).click(function()
			{
				var form = $(this).closest('form');

				var input = $('<input>',
						{
							type: 'hidden',
							name: 'NewButton',
							value: '1'
						} );

				// set class id
				form.find( '[name="ClassID"]' ).val( $(this).attr( 'data-classid' ) );

				form.append( input );

				form.submit();
			});

			// show object versions
			$( '#show-versions' ).click( function()
			{
				var formData = new FormData();
				formData.append( 'contentobjectid', $( self.element ).find( 'input[name="ContentObjectID"]' ).val() );

				$.ajax(
				{
					url: self.options.baseUrl + '/mugo_bootstrap_admin/versions',
					type: 'POST',
					// Form data
					data: formData,
					//dataType: 'text',
					//Options to tell jQuery not to process data or worry about content-type.
					cache: false,
					contentType: false,
					processData: false,
					success: function( data )
					{
						$( '#collapseThree > div' ).html( data );
					},
					error: function( data )
					{
						alert( 'Failed to publish data.' );
					},
				});
			});

			//context menus
			$( '[data-toggle="contextmenu"]' ).ezcontextmenu(
			{
				baseUrl: self.options.baseUrl,
			});

			// remove button
			$( '.remove-button' ).click( function()
			{
				if( confirm( 'Are you sure you want to remove this object?' ) )
				{
					var formData = new FormData();
					formData.append( 'contentobjectid', $( self.element ).find( 'input[name="ContentObjectID"]' ).val() );

					$.ajax(
					{
						url: self.options.baseUrl + '/mugo_bootstrap_admin/remove_object',
						type: 'POST',
						// Form data
						data: formData,
						//dataType: 'text',
						//Options to tell jQuery not to process data or worry about content-type.
						cache: false,
						contentType: false,
						processData: false,
						success: function( data )
						{
							data = JSON.parse( data );

							if( data )
							{
								location.href = self.options.baseUrl + '/content/view/full/' + $( self.element ).find( 'div.full' ).attr( 'data-parent-node-id' );
							}
							else
							{
								alert( 'Failed to remove object' );
							}
						},
						error: function( data )
						{
							alert( 'Failed to remove object.' );
						},
					});
				}
			});

			// bookmark button
			$( '.bookmark-button' ).click( function()
			{
				var context = $( this ).closest( '[data-node-id]' );

				var formData = new FormData();
				formData.append( 'node_id', context.attr( 'data-node-id' ) );
				formData.append( 'name', context.attr( 'data-name') );

				$.ajax(
				{
					url: self.options.baseUrl + '/mugo_bootstrap_admin/bookmark',
					type: 'POST',
					// Form data
					data: formData,
					//dataType: 'text',
					//Options to tell jQuery not to process data or worry about content-type.
					cache: false,
					contentType: false,
					processData: false,
					success: function( data )
					{
						data = JSON.parse( data );

						if( data )
						{
							$.notify( 'Bookmark created' );

						}
						else
						{
							$.notify( 'Failed to create bookmark.' );
						}
					},
					error: function( data )
					{
						$.notify( 'Failed to create bookmark.' );
					},
				});
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
