{* Base URL for JS context *}
{def $base_url = '/'|ezurl( 'no' )}
{if eq( $base_url, '/' )}{set $base_url = ''}{/if}

<script>
	var eZBaseUrl = '{$base_url}';
</script>

{def $page_head_scripts = array(
	'bootstrap.min.js',
	'plugins/jquery.treemenu.js',
	'plugins/jquery.global.js',
	'plugins/jquery.autosaveattribute.js',
	'plugins/jquery.uploadfilesbutton.js',
	'plugins/jquery.editcontent.js',
)}

{ezscript_load( $page_head_scripts )}

<script>
	$( 'body' ).global();
</script>