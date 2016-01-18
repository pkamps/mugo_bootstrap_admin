<div id="attribute-{$attribute.id}" data-id="{$attribute.id}" data-version-nr="{$attribute.version}">
    <div class="btn-toolbar" role="toolbar" aria-label="...">
        <div class="btn-group">
            {if and( $can_create, array( 0, 1 )|contains( $class_content.type ) )}
                <div class="btn-group" role="group">
                    <button type="button" name="CustomActionButton[{$attribute.id}_new_class]" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Create new
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                        {foreach $class_list as $class}
                            <li><a href="#{$class.id}">{$class.name|wash}</a></li>
                        {/foreach}
                    </ul>
                </div>
            {/if}

            <button class="btn btn-default remove-marked" type="button">{'Remove selected'|i18n( 'design/standard/content/datatype' )}</button>
            <button class="btn btn-default add-marked" type="button">Add marked entries</button>
        </div>
    </div>

    {def $related_nodes = array()}
    {if $attribute.has_content}
        {* build node list *}
        {foreach $attribute.content.relation_list as $row}
            {set $related_nodes = $related_nodes|append( fetch( 'content', 'node', hash( 'node_id', $row.node_id ) ) )}
        {/foreach}
    {/if}

    {include uri='design:includes/nodes_table.tpl' entries=$related_nodes}

    {* <p>{'There are no related objects.'|i18n( 'design/standard/content/datatype' )}</p> *}

</div>

<script>
    {literal}
    $(function()
    {
        var id = {/literal}{$attribute.id}{literal};

        $( '#attribute-' + id ).editobjectrelationlist();
    });
    {/literal}
</script>


{* not sure if I want to support it
{if array( 0, 2 )|contains( $class_content.type )}
    <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_browse_objects]" value="{'Add objects'|i18n( 'design/standard/content/datatype' )}" />
    {if $browse_object_start_node}
        <input type="hidden" name="{$attribute_base}_browse_for_object_start_node[{$attribute.id}]" value="{$browse_object_start_node|wash}" />
    {/if}
{else}
    <input class="button-disabled" type="submit" name="CustomActionButton[{$attribute.id}_browse_objects]" value="{'Add objects'|i18n( 'design/standard/content/datatype' )}" disabled="disabled" />
{/if}
*}

{*
{if and( $can_create, array( 0, 1 )|contains( $class_content.type ) )}
    <div class="block">
        <select id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" class="combobox" name="{$attribute_base}_new_class[{$attribute.id}]">
            {section name=Class loop=$class_list}
                <option value="{$:item.id}">{$:item.name|wash}</option>
            {/section}
        </select>
        {if $new_object_initial_node_placement}
            <input type="hidden" name="{$attribute_base}_object_initial_node_placement[{$attribute.id}]" value="{$new_object_initial_node_placement|wash}" />
        {/if}
        <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_new_class]" value="{'Create new object'|i18n( 'design/standard/content/datatype' )}" />
    </div>
{/if}
*}