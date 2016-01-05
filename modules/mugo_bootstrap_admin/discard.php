<?php

/**
 * $_REQUEST
 *
 * contentobjectid
 * versionnr
 *
 */

$return = false;

$contentobject_id = (int) $_REQUEST[ 'contentobjectid' ];
$version_nr = (int) $_REQUEST[ 'versionnr' ];

if( $contentobject_id &&  $version_nr )
{
    $version = eZContentObjectVersion::fetchVersion( $version_nr, $contentobject_id );
    $version->removeThis();

    $eZObj = eZContentObject::fetch( $contentobject_id );

    $result = array(
        'status' => 1,
        'target' => $eZObj->attribute( 'main_node' )->attribute( 'url_alias' ),
    );

    $return = $result;
}

header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
