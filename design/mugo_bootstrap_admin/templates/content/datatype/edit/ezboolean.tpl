{* not tested *}
<div>
	<input id="attribute-{$attribute.id}" data-id="{$attribute.id}" data-version-nr="{$attribute.version}" class="form-control" type="checkbox" {$attribute.data_int|choose( '', 'checked="checked"' )} value="1" />
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
