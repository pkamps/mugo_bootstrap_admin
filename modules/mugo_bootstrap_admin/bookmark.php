<?php

/**
 * $_REQUEST
 *
 * target
 *
 */

$return = false;

$contentobject_id = (int) $_REQUEST[ 'target' ];


header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
