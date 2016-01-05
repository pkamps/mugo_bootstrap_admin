<div id="edit-form">
    <div class="btn-toolbar" role="toolbar">
        <div class="btn-group" role="group">
            <button class="btn btn-primary" type="button" id="publish-button">Send for publishing</button>
            <button class="btn btn-default" type="submit" id="discard-button">
                Discard draft
            </button>
        </div>
    </div>

    {foreach $versions as $version}
        <h2>{$version.name|wash()}</h2>
        <div data-version-id="{$version.id}">
            {foreach $version.data_map as $attribute}
                {switch match=$attribute.contentclass_attribute_identifier}
                {case in=array( 'name', 'caption', 'credit' )}
                    <label>{$attribute.contentclass_attribute_name|wash()}</label>
                {attribute_edit_gui attribute=$attribute}
                {/case}

                {case match='images'}
                    <label>{$attribute.contentclass_attribute_name|wash()}</label>
                {attribute_view_gui attribute=$attribute}
                {/case}
                {/switch}
            {/foreach}
        </div>
    {/foreach}
</div>

<script type="text/javascript">
    {literal}
    $(function()
    {
        $( '#edit-form' ).editcontent();
    });
    {/literal}
</script>
