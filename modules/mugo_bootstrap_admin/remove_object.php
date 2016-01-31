<?php

$return = false;

$objectId = (int) $_REQUEST[ 'contentobjectid' ];

if( $objectId )
{
	$eZObj = eZContentObject::fetch( $objectId );

	if(
		$eZObj &&
		$eZObj->attribute( 'can_remove' ) &&
		$eZObj->attribute( 'status' ) != eZContentObject::STATUS_ARCHIVED
	)
	{
		$result = eZContentOperationCollection::deleteObject( array( $eZObj->attribute( 'main_node_id' ) ), true );
		$return = $result[ 'status' ];
	}
}

header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
