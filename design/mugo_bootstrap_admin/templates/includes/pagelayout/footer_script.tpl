{* Base URL for JS context *}
{def $base_url = '/'|ezurl( 'no' )}
{if eq( $base_url, '/' )}{set $base_url = ''}{/if}

<script>
	var eZBaseUrl = '{$base_url}';
</script>

{ezscript_load( ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ) )}

<script>
{literal}
$(function()
{
	$( 'body' ).global();
});
{/literal}
</script>