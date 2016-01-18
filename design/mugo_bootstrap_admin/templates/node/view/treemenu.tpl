<li data-contentobject-id="{$node.contentobject_id}" data-value="{$node.node_id}" data-type="node_id" class="container">
	<span>{$node.class_identifier|class_icon( small, $node.class_name )}</span>
	<a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
</li>
