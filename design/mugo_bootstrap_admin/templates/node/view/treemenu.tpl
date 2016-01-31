<li data-contentobject-id="{$node.contentobject_id}" data-value="{$node.node_id}" data-type="node_id" class="container">
	<span class="icon-default icon-{$node.class_identifier}"></span>
	<a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
</li>
