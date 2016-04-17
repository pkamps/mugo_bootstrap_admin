<?php
$tpl = eZTemplate::factory();

$allowed_views = array(
	'full',
	'mini',
	'data',
);

$node_id = (int) $_REQUEST[ 'node_id' ];
$view = isset( $_REQUEST[ 'view' ] ) ?  $_REQUEST[ 'view' ] : 'mini';
$view = in_array( $view, $allowed_views ) ? $view : 'mini';

$tpl->setVariable( 'node_id', $node_id );
$tpl->setVariable( 'view', $view );

$Result[ 'content' ] = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/node_view_gui.tpl' );
$Result[ 'pagelayout' ] = false;
