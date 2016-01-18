<?php

/**
 * $_REQUEST
 *
 *
 */

$return = false;

header( 'Content-Type: application/json' );
echo json_encode( $return );
eZExecution::cleanExit();
