<div class="row">
    <div id="attribute-{$attribute.id}" class="col-xs-3" data-toggle="autosave" data-id="{$attribute.id}">
        <input class="form-control" type="datetime-local" />
    </div>
</div>

<script>
    {literal}
    $(function()
    {
        var id = {/literal}{$attribute.id}{literal};
        //$( '#attribute-' + id ).autosaveattribute();
    });
    {/literal}
</script>
