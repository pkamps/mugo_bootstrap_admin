{* ezcss_require( 'dam_image.css' ) *}

{def $version = fetch( 'content', 'version', hash(
    'object_id',  $object.id,
    'version_id', $edit_version) )
}

{* Current gui locale, to be used for class [attribute] name & description fields *}
{def $content_language = ezini( 'RegionalSettings', 'Locale' )}

<div id="edit-form" data-contentobject-id="{$object.id}" data-version-id="{$version.id}">

    {* This is to force form to use publish action instead of 'Manage version' button on enter key press in input and textarea elements. *}
    <input class="defaultbutton hide" type="submit" id="ezedit-default-button" name="PublishButton" value="{'Send for publishing'|i18n( 'design/admin/content/edit' )}" />

    {*
    <div id="leftmenu">
    <a id="objectinfo-showhide" class="show-hide-control" title="{'Show / Hide leftmenu'|i18n( 'design/admin/pagelayout/leftmenu' )}" href="#">&laquo;</a>
    <div id="leftmenu-design">

    {include uri='design:content/edit_menu.tpl'}

    </div>
    </div>
    *}
    <header>
        <h2>
            {$object.name|wash()}
            <small>
                {$object.class_identifier|class_icon( normal, $object.class_name )}
                {first_set( $class.nameList[$content_language], $class.name )|wash()}
            </small>
        </h2>

        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group" role="group">
                <button class="btn btn-primary" type="button" id="publish-button">{'Send for publishing'|i18n( 'design/admin/content/edit' )}</button>
                <button class="btn btn-default" type="submit" id="discard-button">
                    {'Discard draft'|i18n( 'design/admin/content/edit' )}
                </button>

                {* for reference
                <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n( 'design/admin/content/edit' )}" title="{'Publish the contents of the draft that is being edited. The draft will become the published version of the object.'|i18n( 'design/admin/content/edit' )}" />
                <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n( 'design/admin/content/edit' )}" title="{'Store the contents of the draft that is being edited and continue editing. Use this button to periodically save your work while editing.'|i18n( 'design/admin/content/edit' )}" />
                <input class="button" type="submit" name="StoreExitButton" value="{'Store draft and exit'|i18n( 'design/admin/content/edit' )}" title="{'Store the draft that is being edited and exit from edit mode. Use when you need to exit your work and return later to continue.'|i18n( 'design/admin/content/edit' )}" />
                <input class="button" type="submit" name="DiscardButton" value="{'Discard draft'|i18n( 'design/admin/content/edit' )}" onclick="return confirmDiscard( '{'Are you sure you want to discard the draft?'|i18n( 'design/admin/content/edit' )|wash(javascript)}' );" title="{'Discard the draft that is being edited. This will also remove the translations that belong to the draft (if any).'|i18n( 'design/admin/content/edit' ) }" />
                *}
            </div>
        </div>
    </header>

    <br>

    <div class="content">
        {include uri='design:content/edit_validation.tpl'}

        {* not sure what it is other than creating translation
        <div class="context-information">
        {if $object.content_class.description}
        <p class="left class-description">
            {first_set( $class.descriptionList[$content_language], $class.description )|wash}
        </p>
        {/if}
        <p class="right translation">
        {let language_index=0
             from_language_index=0
             translation_list=$content_version.translation_list}

        {section loop=$translation_list}
          {if eq( $edit_language, $item.language_code )}
            {set language_index=$:index}
          {/if}
        {/section}

        {if $is_translating_content}

            {let from_language_object=$object.languages[$from_language]}

            {'Translating content from %from_lang to %to_lang'|i18n( 'design/admin/content/edit',, hash(
                '%from_lang', concat( $from_language_object.name, '&nbsp;<img src="', $from_language_object.locale|flag_icon, '" width="18" height="12" style="vertical-align: middle;" alt="', $from_language_object.locale, '" />' ),
                '%to_lang', concat( $translation_list[$language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$language_index].language_code|flag_icon, '" width="18" height="12" style="vertical-align: middle;" alt="', $translation_list[$language_index].language_code, '" />' ) ) )}

            {/let}

        {else}

            {$translation_list[$language_index].locale.intl_language_name}&nbsp;<img src="{$translation_list[$language_index].language_code|flag_icon}" width="18" height="12" style="vertical-align: middle;" alt="{$translation_list[$language_index].language_code}" />

        {/if}

        {/let}
        </p>
        <div class="break"></div>
        </div>
        *}

        {foreach ezini( 'EditSettings', 'AdditionalTemplates', 'content.ini' ) as $additional_tpl}
            {include uri=concat( 'design:', $additional_tpl )}
        {/foreach}

        <div class="context-attributes">
            {include uri='design:content/edit_attribute.tpl' view_parameters=$view_parameters}

        </div>


        {* anything to keep here?
        </div>
        <div class="controlbar">

        <div class="block">
            {if ezpreference( 'admin_edit_show_re_edit' )}
                <input type="checkbox" name="BackToEdit" />{'Back to edit'|i18n( 'design/admin/content/edit' )}
            {/if}
            <input class="defaultbutton" type="submit" name="PublishButton" value="{'Send for publishing'|i18n( 'design/admin/content/edit' )}" title="{'Publish the contents of the draft that is being edited. The draft will become the published version of the object.'|i18n( 'design/admin/content/edit' )}" />
            <input class="button" type="submit" name="StoreButton" value="{'Store draft'|i18n( 'design/admin/content/edit' )}" title="{'Store the contents of the draft that is being edited and continue editing. Use this button to periodically save your work while editing.'|i18n( 'design/admin/content/edit' )}" />
            <input class="button" type="submit" name="StoreExitButton" value="{'Store draft and exit'|i18n( 'design/admin/content/edit' )}" title="{'Store the draft that is being edited and exit from edit mode. Use when you need to exit your work and return later to continue.'|i18n( 'design/admin/content/edit' )}" />
            <input class="button" type="submit" name="DiscardButton" value="{'Discard draft'|i18n( 'design/admin/content/edit' )}" onclick="return confirmDiscard( '{'Are you sure you want to discard the draft?'|i18n( 'design/admin/content/edit' )|wash(javascript)}' );" title="{'Discard the draft that is being edited. This will also remove the translations that belong to the draft (if any).'|i18n( 'design/admin/content/edit' ) }" />

            {if or(
                    eq( $object.state_identifier_array.2, 'csm_live_states/live' ),
                    eq( $object.class_identifier, 'csm_gallery' ),
                    and(
                            array( 'csm_list_article_item', 'csm_quiz_item', 'csm_quiz_result', 'csm_spectrum_quiz_item', 'csm_spectrum_quiz_result' )|contains( $object.class_identifier ),
                            eq( $object.main_node.parent.object.state_identifier_array.2, 'csm_live_states/live' )
                    )
                  )}
                <input type="checkbox" value="1" name="setupdated" checked="checked" />Reset the Updated time.
            {/if}
            <input type="hidden" name="DiscardConfirm" value="1" />
        </div>

        </div>
        *}

        {* include uri='design:content/edit_relations.tpl' *}


        {* Locations window. *}
        {* section show=eq( ezini( 'EditSettings', 'EmbedNodeAssignmentHandling', 'content.ini' ), 'enabled' ) *}
        {if or( ezpreference( 'admin_edit_show_locations' ),
        count( $invalid_node_assignment_list )|gt(0) )}
            {* We never allow changes to node assignments if the object has been published/archived.
               This is controlled by the $location_ui_enabled variable. *}
            {include uri='design:content/edit_locations.tpl'}
        {else}
            {* This disables all node assignment checking in content/edit *}
            <input type="hidden" name="UseNodeAssigments" value="0" />
        {/if}

    </div>
</div>


<script type="text/javascript">
{literal}
$(function()
{
    $( '#edit-form' ).editcontent();
});
{/literal}
</script>
