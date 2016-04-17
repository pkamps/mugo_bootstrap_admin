{def $selected_id_array=$attribute.content}
<div>
	<select id="attribute-{$attribute.id}" data-id="{$attribute.id}" data-version-nr="{$attribute.version}" class="form-control" {if $attribute.class_content.is_multiselect}multiple{/if}>
		{section var=Options loop=$attribute.class_content.options}
			<option value="{$Options.item.name|wash( xhtml )}" {if $selected_id_array|contains( $Options.item.id )}selected="selected"{/if}>{$Options.item.name|wash( xhtml )}</option>
		{/section}
	</select>
</div>

<script>
	{literal}
	$(function()
	{
		var id = {/literal}{$attribute.id}{literal};

		$( '#attribute-' + id ).autosaveattribute(
		{
			baseUrl: eZBaseUrl,
			initTrigger: function( plugin )
			{
				$(plugin.element).change( function()
				{
					plugin.save();
				});
			},
		});
	});
	{/literal}
</script>
