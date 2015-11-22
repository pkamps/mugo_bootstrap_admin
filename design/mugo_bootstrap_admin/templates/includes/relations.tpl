{def $page_limit = min( ezpreference( 'admin_list_limit' ), 3 )|choose( 10, 10, 25, 50 )
     $offset = first_set( $view_parameters.offset, 0 )}

{def $related = fetch( 'content', 'related_objects', hash(
    'object_id', $node.contentobject_id,
    'all_relations', true(),
    'limit', $page_limit,
    'as_object', true(),
    'load_data_map', false()
))}

{def $rrelated = fetch( 'content', 'reverse_related_objects', hash(
    'object_id', $node.contentobject_id,
    'all_relations', true(),
    'limit', $page_limit,
    'as_object', true(),
    'load_data_map', false()
))}

{def $all = array()}

{foreach $related as $ez_obj}
    {set $all = $all|append( $ez_obj.main_node )}
{/foreach}
{foreach $rrelated as $ez_obj}
    {set $all = $all|append( $ez_obj.main_node )}
{/foreach}

{include uri='design:includes/nodes_table.tpl' entries=$all}
