<?php

$parentNodeId = (int) $_REQUEST[ 'parent_node_id' ];

if( $parentNodeId && !empty( $_FILES ) )
{
    $return = array();
    $upload = new eZContentUpload();

    foreach( $_FILES as $key => $values )
    {
        if( substr( $key, 0, 5) == 'files' )
        {
            $upload->handleUpload( $result, $key, $parentNodeId, false );

            $return[] = array(
                'name' => $values[ 'name' ],
                'errors' => implode( ', ', $result[ 'errors' ] ),
                'contentobject_id' => $result[ 'contentobject_id' ],
            );
        }
    }
}
else
{
    die( 'missing input parameters' );
}

header( 'Content-type: application/json' );
echo json_encode( $return );

eZExecution::cleanExit();
