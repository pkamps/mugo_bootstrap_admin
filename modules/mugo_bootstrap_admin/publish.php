<?php

/**
 * $_REQUEST
 *
 * handleid
 * versionids
 *
 */

$return = false;

$contentobject_id = (int) $_REQUEST[ 'handleid' ];
$versionIds = $_REQUEST[ 'versionids' ];

if( !empty( $versionIds ) )
{
    foreach( $versionIds as $versionId )
    {
        $version = eZContentObjectVersion::fetch( $versionId );

        if( $version )
        {
            $result = eZOperationHandler::execute(
                'content',
                'publish',
                array(
                    'object_id' => $version->attribute( 'contentobject_id' ),
                    'version' => $version->attribute( 'version' ),
                )
            );
        }
    }

    $eZObj = eZContentObject::fetch( $contentobject_id );

    $result[ 'target' ] = $eZObj->attribute( 'main_node' )->attribute( 'url_alias' );
    $return = $result;
}

header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
