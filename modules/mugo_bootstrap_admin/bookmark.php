<?php

/**
 * $_REQUEST
 *
 * node_id
 *
 */

$return = false;

$nodeId = (int) $_REQUEST[ 'node_id' ];
$name = $_REQUEST[ 'name' ];

if( $nodeId )
{
	$parentNodeId = eZUser::currentUser()->attribute( 'contentobject' )->attribute( 'main_node_id' );

	$attributes = array(
		'name' => $name,
		'node_id' => $nodeId,
	);

	$return = ContentClass_Handler::create( $attributes, $parentNodeId, 'bookmark' );
}

header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
