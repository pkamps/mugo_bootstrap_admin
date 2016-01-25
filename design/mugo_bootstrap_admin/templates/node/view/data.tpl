{foreach $node.data_map as $attribute}
	<label>Label:</label>
	{attribute_view_gui attribute=$attribute}
{/foreach}
