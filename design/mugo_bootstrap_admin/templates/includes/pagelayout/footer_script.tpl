<script>
	var eZBaseUrl = {'/'|ezurl()};
</script>

{def $page_head_scripts = array(
	'bootstrap.min.js',
	'plugins/jquery.treemenu.js',
	'plugins/jquery.global.js',
	'plugins/jquery.autosaveattribute.js',
)}

{ezscript_load( $page_head_scripts )}

<script>
	$( 'body' ).global();
</script>