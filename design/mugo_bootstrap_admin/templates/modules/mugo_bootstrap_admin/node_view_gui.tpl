{*
    INPUT
    
        node_id    : it's the node ID... surprise
        view       :
*}
{if is_unset( $view )}
	{def $view = 'mini'}
{/if}

{def $node = fetch( 'content', 'node', hash( 'node_id', $node_id ) )}

{node_view_gui content_node=$node view=$view}
