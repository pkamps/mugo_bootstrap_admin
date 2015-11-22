<li data-node-id="{$node.node_id}" class="container">
	<span>{$node.class_identifier|class_icon( small, $node.class_name )}</span>
	<a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
</li>
