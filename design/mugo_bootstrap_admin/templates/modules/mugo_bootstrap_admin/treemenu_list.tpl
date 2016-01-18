{def
	$limit = 200
	$parent = fetch( 'content', 'node', hash( 'node_id', $parent_node_id ) )
	$params = hash(
		'parent_node_id', $parent_node_id,
		'limit', $limit,
		'sort_by', $parent.sort_array,
	)
	$node_count = fetch( 'content', 'list_count', $params )
	$nodes = fetch( 'content', 'list', $params )
}

<ul>
	{foreach $nodes as $node}
		{node_view_gui content_node=$node view='treemenu'}
	{/foreach}
	{if $node_count|gt( $limit )}
		<li><a>more...</a></li>
	{/if}
</ul>
