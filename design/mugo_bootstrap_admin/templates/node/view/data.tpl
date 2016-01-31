{foreach $node.data_map as $attribute}
	<div class="form-group">
		<label>{$attribute.contentclass_attribute_name|wash()}</label>
		<div>{attribute_view_gui attribute=$attribute}</div>
	</div>
{/foreach}
