<?php

$return = false;
$newParentNodeId = (int) $_REQUEST[ 'new_parent_node_id' ];
$nodeId = (int) $_REQUEST[ 'node_id' ];

if( $newParentNodeId && $nodeId )
{
	$return = eZContentObjectTreeNodeOperations::move( $nodeId, $newParentNodeId );
}

header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
