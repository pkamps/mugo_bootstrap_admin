{if $node.data_map.link.has_content}
    <li data-value="{$node.node_id}">
        <span class="icon-default icon-{$node.class_identifier}"></span>
        <a href={$node.data_map.link.content|ezurl()}>{$node.name|wash()}</a>
    </li>
{elseif $node.data_map.node_id.has_content}
    {def $target_node = fetch( 'content', 'node', hash( 'node_id', $node.data_map.node_id.content ) )}

    <li data-value="{$target_node.node_id}" class="container">
        <span class="icon-default icon-{$node.class_identifier}"></span>
        <a href={$target_node.url_alias|ezurl()}>{$node.name|wash()}</a>
    </li>
{else}
    <li data-value="{$node.node_id}">
        <span class="icon-default icon-{$node.class_identifier}"></span>
        <a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
    </li>
{/if}
