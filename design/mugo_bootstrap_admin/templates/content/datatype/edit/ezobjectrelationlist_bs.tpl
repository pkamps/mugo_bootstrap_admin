<div class="proto-objectrelationlist">
    {if $attribute.has_content}
        <table class="table">
            <tr class="bglight">
                <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/standard/content/datatype' )}" onclick="ezjs_toggleCheckboxes( document.editform, '{$attribute_base}_selection[{$attribute.id}][]' ); return false;" title="{'Invert selection.'|i18n( 'design/standard/content/datatype' )}" /></th>
                <th>{'Name'|i18n( 'design/standard/content/datatype' )}</th>
                <th>{'Type'|i18n( 'design/standard/content/datatype' )}</th>
                <th>{'Section'|i18n( 'design/standard/content/datatype' )}</th>
                <th><span title="{'The related objects will be edited in the same language as this object. If such translations do not exist they will be created, based on the source language of your choice.'|i18n( 'design/standard/content/datatype' )}">{'Translation base'|i18n( 'design/standard/content/datatype' )}</span></th>
                <th class="tight">{'Order'|i18n( 'design/standard/content/datatype' )}</th>
            </tr>
            {section name=Relation loop=$attribute.content.relation_list sequence=array( bglight, bgdark )}
                <tr class="{$:sequence}">
                    {if $:item.is_modified}
                        {* Remove. *}
                        <td>
                            <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_remove_{$Relation:index}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="checkbox" name="{$attribute_base}_selection[{$attribute.id}][]" value="{$:item.contentobject_id}" />
                            <input type="hidden" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="{$:item.contentobject_id}" />
                        </td>
                        <td colspan="4">

                            {let object=fetch( content, object, hash( object_id, $:item.contentobject_id, object_version, $:item.contentobject_version ) )
                            version=fetch( content, version, hash( object_id, $:item.contentobject_id, version_id, $:item.contentobject_version ) )}
                            <fieldset>
                                <legend>{'Edit <%object_name> [%object_class]'|i18n( 'design/standard/content/datatype',, hash( '%object_name', $Relation:object.name, '%object_class', $Relation:object.class_name ) )|wash}</legend>

                                {section name=Attribute loop=$:version.contentobject_attributes}
                                    <div class="block">
                                        {if $:item.display_info.edit.grouped_input}
                                            <fieldset>
                                                <legend>{$:item.contentclass_attribute.name}</legend>
                                                {attribute_edit_gui attribute_base=concat( $attribute_base, '_ezorl_edit_object_', $Relation:item.contentobject_id ) html_class='half' attribute=$:item}
                                            </fieldset>
                                        {else}
                                            <label>{$:item.contentclass_attribute.name}:</label>
                                            {attribute_edit_gui attribute_base=concat( $attribute_base, '_ezorl_edit_object_', $Relation:item.contentobject_id ) html_class='half' attribute=$:item}
                                        {/if}
                                    </div>
                                {/section}
                                {/let}
                            </fieldset>
                        </td>

                        {* Order. *}
                        <td><input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_order" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" size="2" type="text" name="{$attribute_base}_priority[{$attribute.id}][]" value="{$:item.priority}" /></td>
                    {else}
                        {let object=fetch( content, object, hash( object_id, $:item.contentobject_id, object_version, $:item.contentobject_version ) )}
                            {* Remove. *}
                            <td>
                                <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_remove_{$Relation:index}" class="ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}" type="checkbox" name="{$attribute_base}_selection[{$attribute.id}][]" value="{$:item.contentobject_id}" />
                                <input type="hidden" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[]" value="{$:item.contentobject_id}" />
                            </td>

                            {* Name *}
                            <td>{$Relation:object.name|wash()}</td>

                            {* Type *}
                            <td>{$Relation:object.class_name|wash()}</td>

                            {* Section *}
                            <td>{fetch( section, object, hash( section_id, $Relation:object.section_id ) ).name|wash()}</td>

                            {* Translation base *}
                            <td>
                                {if $Relation:object.language_codes|contains( $attribute.language_code )}
                                    <span title="{'This object is already translated, the existing translation will be used.'|i18n( 'design/standard/content/datatype' )}">
                                    {$attribute.object.current_language_object.name|wash()}
                                </span>
                                {else}
                                    {def $languages=$Relation:object.languages}
                                    <select name="{$attribute_base}_translation_source_{$attribute.id}_{$Relation:object.id}" title="{'This object is not translated, please select the language the new translation will be based on.'|i18n( 'design/standard/content/datatype' )}">
                                        {foreach $languages as $language}
                                            <option value="{$language.locale|wash}" {if $language.locale|eq( $Relation:object.initial_language_code )}selected="selected"{/if}>{$language.name|wash}</option>
                                        {/foreach}
                                        <option value="">{'None'|i18n( 'design/standard/content/datatype' )}</option>
                                    </select>
                                    {undef $languages}
                                {/if}
                            </td>

                            {* Order. *}
                            <td><input size="2" type="text" name="{$attribute_base}_priority[{$attribute.id}][]" value="{$:item.priority}" /></td>
                        {/let}
                    {/if}
                </tr>
            {/section}
        </table>
    {else}
        <p>{'There are no related objects.'|i18n( 'design/standard/content/datatype' )}</p>
    {/if}

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

            <button class="btn btn-default" type="submit" name="CustomActionButton[{$attribute.id}_remove_objects]">{'Remove selected'|i18n( 'design/standard/content/datatype' )}</button>&nbsp;
            <button class="btn btn-default" type="submit" name="CustomActionButton[{$attribute.id}_edit_objects]">{'Edit selected'|i18n( 'design/standard/content/datatype' )}</button>
            <button class="btn btn-default add-selected" type="button">Add selected nodes</button>
        </div>
    </div>
</div>


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