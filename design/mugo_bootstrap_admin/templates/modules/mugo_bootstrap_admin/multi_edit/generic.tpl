{foreach $versions as $version}
    <h2>{$version.name|wash()}</h2>
    {foreach $version.data_map as $attribute}
        <label>{$attribute.contentclass_attribute_name|wash()}</label>
        {attribute_edit_gui attribute=$attribute}
    {/foreach}
{/foreach}