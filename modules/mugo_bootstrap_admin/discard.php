<?php

/**
 * $_REQUEST
 *
 * contentobjectid
 * versionnr
 *
 */

$return = false;

$contentobject_id = (int) $_REQUEST[ 'constructid' ];
$versionIds = $_REQUEST[ 'versionids' ];

if( !empty( $versionIds ) )
{
    foreach( $versionIds as $versionId )
    {
        $version = eZContentObjectVersion::fetch( $versionId );
        $version->removeThis();
    }

    $targetUrl = '';

    if( $contentobject_id )
    {
        $eZObj = eZContentObject::fetch( $contentobject_id );
        $targetUrl = $eZObj->attribute( 'main_node' )->attribute( 'url_alias' );
    }

    $result = array(
        'status' => 1,
        'target' => $targetUrl,
    );

    $return = $result;
}

header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
