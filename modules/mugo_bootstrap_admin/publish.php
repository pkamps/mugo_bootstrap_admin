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
    $result = eZOperationHandler::execute(
        'content',
        'publish',
        array(
            'object_id' => $contentobject_id,
            'version' => $version_nr,
        )
    );

    $return = $result[ 'status' ] ==  1;
}

echo $return;
eZExecution::cleanExit();
