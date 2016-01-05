<div>
    <textarea id="attribute-{$attribute.id}" data-id="{$attribute.id}" data-version-nr="{$attribute.version}" class="form-control" type="text">{$attribute.data_text|wash( xhtml )}</textarea>
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
                var saveTimer;

                $(plugin.element)
                        .keydown( function()
                        {
                            clearTimeout( saveTimer );
                            saveTimer = setTimeout( function()
                            {
                                plugin.save();
                            }, 2000);
                        });
            },
        });
    });
    {/literal}
</script>
