<div id="edit-form" data-contentobject-id="{$construct_id}">
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

            {switch match=$version.contentobject.class_identifier}
                {case match="csm_gallery"}
                    {foreach $version.data_map as $attribute}
                        {switch match=$attribute.contentclass_attribute_identifier}
                            {case in=array( 'title' )}
                                <label>{$attribute.contentclass_attribute_name|wash()}</label>
                                {attribute_edit_gui attribute=$attribute}
                            {/case}
                        {/switch}
                    {/foreach}
                {/case}

                {case}

                    <div>
                        {attribute_view_gui attribute=$version.data_map.images}
                    </div>

                    {foreach $version.data_map as $attribute}
                        {switch match=$attribute.contentclass_attribute_identifier}
                            {case in=array( 'name', 'caption', 'credit' )}
                                <label>{$attribute.contentclass_attribute_name|wash()}</label>
                                {attribute_edit_gui attribute=$attribute}
                            {/case}
                        {/switch}
                    {/foreach}
                {/case}
            {/switch}

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
