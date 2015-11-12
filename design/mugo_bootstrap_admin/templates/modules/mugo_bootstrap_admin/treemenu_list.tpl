{def $nodes = fetch( 'content', 'list', hash(
							'parent_node_id', $parent_node_id
))}

<ul>
{foreach $nodes as $node}
	{node_view_gui content_node=$node view='treemenu'}
{/foreach}
</ul>
