{default
    $view_parameters            = array()
    $attribute_categorys        = ezini( 'ClassAttributeSettings', 'CategoryList', 'content.ini' )
    $attribute_default_category = ezini( 'ClassAttributeSettings', 'DefaultCategory', 'content.ini' )
}
{def $description = ''}

<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
    {foreach $content_attributes_grouped_data_map|reverse() as $attribute_group => $content_attributes_grouped}

    <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="heading-{$attribute_group}">
            <h4 class="panel-title">
                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$attribute_group}" aria-expanded="true" aria-controls="collapse-{$attribute_group}">
                    {$attribute_categorys[$attribute_group]}
                </a>
            </h4>
        </div>

        <div id="collapse-{$attribute_group}" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="heading-{$attribute_group}">
            <div class="panel-body">
                {foreach $content_attributes_grouped as $attribute_identifier => $attribute}
                    {def $contentclass_attribute = $attribute.contentclass_attribute}
                    <div class="ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute_identifier}">

                        {* Show view GUI if we can't edit, otherwise: show edit GUI. *}
                        {if and( eq( $attribute.can_translate, 0 ), ne( $object.initial_language_code, $attribute.language_code ) )}
                            <label>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                {if $attribute.can_translate|not} <span class="nontranslatable">({'not translatable'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}:
                                {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
                            </label>
                            {if $is_translating_content}
                                <div class="original">
                                    {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                </div>
                            {else}
                                {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                            {/if}
                        {else}
                            {if $attribute.display_info.edit.grouped_input}
                                {if $contentclass_attribute.description}
                                    {set $description = first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description, '' )}
                                {/if}
                                
                                <div class="form-group">
                                    <fieldset>
                                        <legend {if $attribute.has_validation_error} class="message-error"{/if}>
                                            <span class="long-legend-wrap">{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                                {if $attribute.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
                                                {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
                                            </span>
                                            {if $description}
                                                <button type="button" class="btn btn-sm btn-default" data-container="body" data-toggle="popover" title="Help" data-placement="top" data-content="{$description|wash()}">
                                                    <i class="glyphicon glyphicon-question-sign"></i>
                                                </button>
                                            {/if}
                                        </legend>
                                        {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                                    </fieldset>
                                </div>
                            {else}
                                <div class="form-group">
                                    <label data-toggle="popover" title="{$description|wash()}" {if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                        {if $attribute.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
                                        {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}:
                                        {if $description}
                                            <button type="button" class="btn btn-sm btn-default" data-container="body" data-toggle="popover" title="Help" data-placement="top" data-content="{$description|wash()}">
                                                <i class="glyphicon glyphicon-question-sign"></i>
                                            </button>
                                        {/if}
                                    </label>
                                    {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
                                </div>
                            {/if}
                        {/if}

                    </div>
                    {undef $contentclass_attribute}
                {/foreach}
            </div>
        </div>
    </div>
    {/foreach}
</div>

{*
{foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}
    {if $attribute_group|ne( $attribute_default_category )}
        <div class="ezcca-collapsible ezcca-attributes-group-{$attribute_group|wash}">
        <legend><a href="JavaScript:void(0);">{$attribute_categorys[$attribute_group]}</a></legend>
        <div class="ezcca-collapsible-fieldset-content">
    {/if}

    {if $attribute_group|ne( $attribute_default_category )}
        </div>
        </fieldset>
    {/if}
{/foreach}
*}

{run-once}
{* if is_set( $content_attributes_grouped_data_map[1] ) *}
<script type="text/javascript">
{literal}

jQuery(function( $ )
{
    $('fieldset.ezcca-collapsible legend a').click( function()
    {
        var container = $( this.parentNode.parentNode ), inner = container.find('div.ezcca-collapsible-fieldset-content');
        if ( container.hasClass('ezcca-collapsed') )
        {
            container.removeClass('ezcca-collapsed');
            inner.slideDown( 150 );
        }
        else
        {
            inner.slideUp( 150, function(){
                $( this.parentNode ).addClass('ezcca-collapsed');
            });
        }
    });
    // Collapse by default, unless the group has at least one attribute with label.message-error
    $('fieldset.ezcca-collapsible').each( function(){
        if ( $(this).find('label.message-error').length == 0 )
        {
            $(this).addClass('ezcca-collapsed').find('div.ezcca-collapsible-fieldset-content').hide();
        }
    } );
});

{/literal}
</script>
{* /if *}
{/run-once}
{/default}
