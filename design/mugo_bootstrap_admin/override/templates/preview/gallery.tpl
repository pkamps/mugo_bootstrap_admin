<h1>{$node.name|wash()} <small>{$node.class_name|wash()}</small></h1>
<p>
	Last update <i>{$node.object.current.modified|l10n( 'datetime' )}</i>,
	<a href="#">{$node.object.current.creator.name|wash()}</a>
</p>

{if $node.data_map.images.has_content}
	<p>
		{def $temp = ''}
		{foreach $node.data_map.images.content.relation_list as $row}
			{set $temp = fetch( 'content', 'node', hash( 'node_id', $row[ 'node_id' ] ) )}

			{attribute_view_gui
				attribute=$temp.data_map.images
				css_class='img-thumbnail'
				image_alias='standard_100x67'
			}
		{/foreach}
	</p>
{/if}
