{let class_content=$attribute.class_content
class_list=fetch( class, list, hash( class_filter, $class_content.class_constraint_list ) )
     can_create=true()
     new_object_initial_node_placement=false()
     browse_object_start_node=false()}

{if $class_content.selection_type|ne( 0 )} {* If current selection mode is not 'browse'. *}
        {default attribute_base=ContentObjectAttribute}
        {let parent_node=cond( and( is_set( $class_content.default_placement.node_id ),
                               $class_content.default_placement.node_id|eq( 0 )|not ),
                               $class_content.default_placement.node_id, 1 )
         nodesList=cond( and( is_set( $class_content.class_constraint_list ), $class_content.class_constraint_list|count|ne( 0 ) ),
                         fetch( content, tree,
                                hash( parent_node_id, $parent_node,
                                      class_filter_type,'include',
                                      class_filter_array, $class_content.class_constraint_list,
                                      sort_by, array( 'name',true() ),
                                      main_node_only, true() ) ),
                         fetch( content, list,
                                hash( parent_node_id, $parent_node,
                                      sort_by, array( 'name', true() )
                                     ) )
                        )
        }
        {switch match=$class_content.selection_type}

        {case match=1} {* Dropdown list *}
        <div class="buttonblock">
            <input type="hidden" name="single_select_{$attribute.id}" value="1" />
            {if ne( count( $nodesList ), 0)}
            <select name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]">
                {if $attribute.contentclass_attribute.is_required|not}
                    <option value="no_relation" {if eq( $attribute.content.relation_list|count, 0 )} selected="selected"{/if}>{'No relation'|i18n( 'design/standard/content/datatype' )}</option>
                {/if}
                {section var=node loop=$nodesList}
                    <option value="{$node.contentobject_id}"
                    {if ne( count( $attribute.content.relation_list ), 0)}
                    {foreach $attribute.content.relation_list as $item}
                         {if eq( $item.contentobject_id, $node.contentobject_id )}
                            selected="selected"
                            {break}
                         {/if}
                    {/foreach}
                    {/if}
                    >
                    {$node.name|wash}</option>
                {/section}
            </select>
            {/if}
            </div>
        {/case}

        {case match=2} {* radio buttons list *}
            <input type="hidden" name="single_select_{$attribute.id}" value="1" />
            {if $attribute.contentclass_attribute.is_required|not}
                <input type="radio" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="no_relation"
                {if eq( $attribute.content.relation_list|count, 0 )} checked="checked"{/if}>{'No relation'|i18n( 'design/standard/content/datatype' )}<br />{/if}
            {section var=node loop=$nodesList}
                <input type="radio" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="{$node.contentobject_id}"
                {if ne( count( $attribute.content.relation_list ), 0)}
                {foreach $attribute.content.relation_list as $item}
                     {if eq( $item.contentobject_id, $node.contentobject_id )}
                            checked="checked"
                            {break}
                     {/if}
                {/foreach}
                {/if}
                >
                {$node.name|wash} <br/>
            {/section}
        {/case}

        {case match=3} {* check boxes list *}
            {section var=node loop=$nodesList}
                <input type="checkbox" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[{$node.node_id}]" value="{$node.contentobject_id}"
                {if ne( count( $attribute.content.relation_list ), 0)}
                {foreach $attribute.content.relation_list as $item}
                     {if eq( $item.contentobject_id, $node.contentobject_id )}
                            checked="checked"
                            {break}
                     {/if}
                {/foreach}
                {/if}
                />
                {$node.name|wash} <br/>
            {/section}
        {/case}

        {case match=4}4 {* Multiple List *}
            <div class="buttonblock">
            {if ne( count( $nodesList ), 0)}
            <select name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" size="10" multiple>
                {section var=node loop=$nodesList}
                    <option value="{$node.contentobject_id}"
                    {if ne( count( $attribute.content.relation_list ), 0)}
                    {foreach $attribute.content.relation_list as $item}
                         {if eq( $item.contentobject_id, $node.contentobject_id )}
                            selected="selected"
                            {break}
                         {/if}
                    {/foreach}
                    {/if}
                    >
                    {$node.name|wash}</option>
                {/section}
            </select>
            {/if}
            </div>
        {/case}

        {case match=5}5 {* Template based, multi *}
            <div class="buttonblock">
            <div class="templatebasedeor">
                <ul>
                {section var=node loop=$nodesList}
                   <li>
                        <input type="checkbox" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[{$node.node_id}]" value="{$node.contentobject_id}"
                        {if ne( count( $attribute.content.relation_list ), 0)}
                        {foreach $attribute.content.relation_list as $item}
                           {if eq( $item.contentobject_id, $node.contentobject_id )}
                               checked="checked"
                               {break}
                           {/if}
                        {/foreach}
                        {/if}
                        >
                        {node_view_gui content_node=$node view=objectrelationlist}
                   </li>
                {/section}
                </ul>
            </div>
            </div>
        {/case}

        {case match=6}6 {* Template based, single *}
            <div class="buttonblock">
            <div class="templatebasedeor">
            <ul>
                {if $attribute.contentclass_attribute.is_required|not}
            <li>
                         <input value="no_relation" type="radio" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" {if eq( $attribute.content.relation_list|count, 0 )} checked="checked"{/if}>{'No relation'|i18n( 'design/standard/content/datatype' )}<br />
                    </li>
                {/if}
                {section var=node loop=$nodesList}
                    <li>
                        <input type="radio" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="{$node.contentobject_id}"
                        {if ne( count( $attribute.content.relation_list ), 0)}
                        {foreach $attribute.content.relation_list as $item}
                           {if eq( $item.contentobject_id, $node.contentobject_id )}
                               checked="checked"
                               {break}
                           {/if}
                        {/foreach}
                        {/if}
                        >
                        {node_view_gui content_node=$node view=objectrelationlist}
                    </li>
                {/section}
           </ul>
           </div>
           </div>
        {/case}
        {/switch}

        {if eq( count( $nodesList ), 0 )}
            {def $parentnode = fetch( 'content', 'node', hash( 'node_id', $parent_node ) )}
            {if is_set( $parentnode )}
                <p>{'Parent node'|i18n( 'design/standard/content/datatype' )}: {node_view_gui content_node=$parentnode view=objectrelationlist} </p>
            {/if}
            <p>{'Allowed classes'|i18n( 'design/standard/content/datatype' )}:</p>
            {if ne( count( $class_content.class_constraint_list ), 0 )}
                 <ul>
                 {foreach $class_content.class_constraint_list as $class}
                       <li>{$class}</li>
                 {/foreach}
                 </ul>
            {else}
                 <ul>
                       <li>{'Any'|i18n( 'design/standard/content/datatype' )}</li>
                 </ul>
            {/if}
            <p>{'There are no objects of allowed classes'|i18n( 'design/standard/content/datatype' )}.</p>
        {/if}

        {* Create object *}
        {section show = and( is_set( $class_content.default_placement.node_id ), ne( 0, $class_content.default_placement.node_id ), ne( '', $class_content.object_class ) )}
            {def $defaultNode = fetch( content, node, hash( node_id, $class_content.default_placement.node_id ))}
            {if and( is_set( $defaultNode ), $defaultNode.can_create )}
                <div id='create_new_object_{$attribute.id}' style="display:none;">
                     <p>{'Create new object with name'|i18n( 'design/standard/content/datatype' )}:</p>
                     <input name="attribute_{$attribute.id}_new_object_name" id="attribute_{$attribute.id}_new_object_name"/>
                </div>
                <input class="button" type="button" value="Create New" name="CustomActionButton[{$attribute.id}_new_object]"
                       onclick="var divfield=document.getElementById('create_new_object_{$attribute.id}');divfield.style.display='block';
                                var editfield=document.getElementById('attribute_{$attribute.id}_new_object_name');editfield.focus();this.style.display='none';return false;" />
           {/if}
        {/section}

        {/let}
        {/default}
{else}    {* Standard mode is browsing *}
    <div class="block" id="ezobjectrelationlist_browse_{$attribute.id}">
    {if is_set( $attribute.class_content.default_placement.node_id )}
         {set browse_object_start_node = $attribute.class_content.default_placement.node_id}
    {/if}

    {* Optional controls. *}
    {include uri='design:content/datatype/edit/ezobjectrelationlist_controls.tpl'}

    {* Advanced interface. *}
    {if eq( ezini( 'BackwardCompatibilitySettings', 'AdvancedObjectRelationList' ), 'enabled' )}
        {include uri='design:content/datatype/edit/ezobjectrelationlist_bs.tpl'}

    {* Simple interface. *}
    {else}
        <h4>{'Objects in the relation'|i18n( 'design/standard/content/datatype' )}</h4>
        <table class="list{if $attribute.content.relation_list|not} hide{/if}" cellspacing="0">
        <thead>
        <tr>
            <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/standard/content/datatype' )}" onclick="ezjs_toggleCheckboxes( document.editform, '{$attribute_base}_selection[{$attribute.id}][]' ); return false;" title="{'Invert selection.'|i18n( 'design/standard/content/datatype' )}" /></th>
            <th>{'Name'|i18n( 'design/standard/content/datatype' )}</th>
            <th>{'Type'|i18n( 'design/standard/content/datatype' )}</th>
            <th>{'Section'|i18n( 'design/standard/content/datatype' )}</th>
            <th>{'Published'|i18n( 'design/standard/content/datatype' )}</th>
            <th class="tight">{'Order'|i18n( 'design/standard/content/datatype' )}</th>
        </tr>
        </thead>
        <tbody>
        {if $attribute.content.relation_list}
            {foreach $attribute.content.relation_list as $item sequence array( 'bglight', 'bgdark' ) as $style}
              {def $object = fetch( content, object, hash( object_id, $item.contentobject_id ) )}
              <tr class="{$style}">
                {* Remove. *}
                <td><input type="checkbox" name="{$attribute_base}_selection[{$attribute.id}][]" value="{$item.contentobject_id}" />
                <input type="hidden" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="{$item.contentobject_id}" /></td>

                {* Name *}
                <td>{$object.name|wash()}</td>

                {* Type *}
                <td>{$object.class_name|wash()}</td>

                {* Section *}
                <td>{fetch( section, object, hash( section_id, $object.section_id ) ).name|wash()}</td>

                {* Published. *}
                <td>{if $item.in_trash}
                        {'No'|i18n( 'design/standard/content/datatype' )}
                    {else}
                        {'Yes'|i18n( 'design/standard/content/datatype' )}
                    {/if}
                </td>

                {* Order. *}
                <td><input size="2" type="text" name="{$attribute_base}_priority[{$attribute.id}][]" value="{$item.priority}" /></td>

              </tr>
              {undef $object}
            {/foreach}
        {else}
          <tr class="bgdark">
            <td><input type="checkbox" name="{$attribute_base}_selection[{$attribute.id}][]" value="--id--" />
            <input type="hidden" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="no_relation" /></td>
            <td>--name--</td>
            <td>--class-name--</td>
            <td>--section-name--</td>
            <td>--published--</td>
            <td><input size="2" type="text" name="{$attribute_base}_priority[{$attribute.id}][]" value="0" /></td>
          </tr>
        {/if}
        </tbody>
        </table>
        {if $attribute.content.relation_list|not}
            <p class="ezobject-relation-no-relation">{'There are no related objects.'|i18n( 'design/standard/content/datatype' )}</p>
        {/if}

        <div class="block inline-block">
	        {if $attribute.content.relation_list}
	            <input class="button ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_objects]" value="{'Remove selected'|i18n( 'design/standard/content/datatype' )}" title="{'Remove selected elements from the relation'|i18n( 'design/standard/content/datatype' )}" />
	        {else}
	            <input class="button-disabled ezobject-relation-remove-button" type="submit" name="CustomActionButton[{$attribute.id}_remove_objects]" value="{'Remove selected'|i18n( 'design/standard/content/datatype' )}" disabled="disabled" />
	        {/if}
        </div>
        <h4>{'Add objects in the relation'|i18n( 'design/standard/content/datatype' )}</h4>
        <div class="left">
	        {if $browse_object_start_node}
	            <input type="hidden" name="{$attribute_base}_browse_for_object_start_node[{$attribute.id}]" value="{$browse_object_start_node|wash}" />
	        {/if}

            {if is_set( $attribute.class_content.class_constraint_list[0] )}
                <input type="hidden" name="{$attribute_base}_browse_for_object_class_constraint_list[{$attribute.id}]" value="{$attribute.class_content.class_constraint_list|implode(',')}" />
            {/if}

	        <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_browse_objects]" value="{'Add existing objects'|i18n( 'design/standard/content/datatype' )}" title="{'Browse to add existing objects in this relation'|i18n( 'design/standard/content/datatype' )}" />
            {include uri='design:content/datatype/edit/ezobjectrelationlist_ajaxuploader.tpl'}

        </div>
        <div class="right">
            <input type="text" class="halfbox hide ezobject-relation-search-text" />
            <input type="submit" class="button hide ezobject-relation-search-btn" name="CustomActionButton[{$attribute.id}_browse_objects]" value="{'Find objects'|i18n( 'design/standard/content/datatype' )}" />
        </div>
        <div class="break"></div>
        <div class="block inline-block ezobject-relation-search-browse hide"></div>

        {include uri='design:content/datatype/edit/ezobjectrelation_ajax_search.tpl'}
	{/if}
    </div><!-- /div class="block" id="ezobjectrelationlist_browse_{$attribute.id}" -->
{/if}
{/let}
