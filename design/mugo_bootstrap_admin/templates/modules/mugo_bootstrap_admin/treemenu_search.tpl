{def $results = fetch( 'ezfind', 'search', hash(
							'query', $query
))}

<ul>
{foreach $results.SearchResult as $node}
	{node_view_gui content_node=$node view='treemenu'}
{/foreach}
</ul>
