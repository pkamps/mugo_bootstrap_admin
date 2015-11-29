<div class="row">
    <div id="attribute-{$attribute.id}" class="col-xs-3" data-toggle="autosave" data-id="{$attribute.id}">
        <input class="form-control" type="datetime-local" />
    </div>
</div>

{* PEK: strange position but it's not working otherwise *}
<script>
    {literal}
    $(function()
    {
        //alert('d');
        var id = {/literal}{$attribute.id}{literal};
        $( '#attribute-' + id ).autosaveattribute();
    });
    {/literal}
</script>
