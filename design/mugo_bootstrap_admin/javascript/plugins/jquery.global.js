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

			// generic events
			$( 'button[data-href]' ).click(function()
			{
				location.href = $(this).attr( 'data-href' );
			});

			// popovers
			$( "[data-toggle=popover]" ).popover();

			self.init_full_view();
		},

		init_full_view : function()
		{
			$( '#view-button li a' ).click( function()
			{
				// TODO: incomplete
				$( '#viewModal iframe' ).attr( 'src', '/content/versionview/920791/5/eng-US/site_access/site_origin' );

				$( '#viewModal' ).modal(
				{
					backdrop: true,
				});

				return false;
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
