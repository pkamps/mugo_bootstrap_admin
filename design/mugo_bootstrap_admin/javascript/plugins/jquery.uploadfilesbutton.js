;(function ( $, window, document, undefined )
{
    var pluginName = 'uploadfilesbutton',
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

            self.formData = new FormData();
            self.initEvents();
        },

        initEvents : function()
        {
            var self = this;

            $(self.element).find( 'button' ).click( function()
            {
                $(self.element).find( 'input' ).click();
                return false;
            });

            $(self.element).find( 'input' ).change( function()
            {
                $.each( this.files, function(index)
                {
                    self.formData.append( 'files' + index, this );
                });

                self.upload();
            });
        },

        upload : function()
        {
            var self = this;

            self.formData.append( 'ezxform_token', $('[name="ezxform_token"]' ).val() );
            self.formData.append( 'parent_node_id', $('[name="NodeID"]' ).val() );

            $.ajax(
                {
                    url: self.options.baseUrl + 'mugo_bootstrap_admin/upload_files',
                    type: 'POST',
                    // Form data
                    data: self.formData,
                    //headers: { 'Content-Disposition' : 'filename=' +  encodeURIComponent( 'fips_upload_file.pdf' ) + ';' },
                    dataType: 'json',
                    //Options to tell jQuery not to process data or worry about content-type.
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function( data )
                    {
                        self.afterUpload( data );
                    },
                    error: function( data )
                    {
                        alert( 'Failed to upload files.' );
                    },
                });
        },

        afterUpload : function( data )
        {
            var self = this;

            var message = 'Files uploaded:\n\n';
            var result;

            $.each( data, function()
            {
                result = this.errors !== '' ? this.errors : 'success';
                message = message + this.name + ': ' + result + '\n';
            });

            message = message + '\n\n Do you want to edit the files now?';

            var editRedirect = confirm( message );

            if( editRedirect )
            {
                var parameters =
                {
                    contentobject_ids: [],
                    redirect_node_id: $('[name="NodeID"]' ).val(),
                }

                $.each( data, function()
                {
                    parameters.contentobject_ids.push( this.contentobject_id );
                });

                var url = self.options.baseUrl + '/admin_edit/multi_edit?' + $.param( parameters );

                location.href = url;
            }
            else
            {
                location.reload();
            }
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