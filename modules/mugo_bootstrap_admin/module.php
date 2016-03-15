<?php

$Module = array( 'name' => 'Mugo Bootstrap Admin' );

$ViewList = array();
$ViewList[ 'treemenu_list' ] = array(
		'script' => 'treemenu_list.php',
);

$ViewList[ 'upload_files' ] = array(
		'functions'  => array( 'upload_files' ),
		'ui_context' => 'edit',
		'script'     => 'upload_files.php',
);

$ViewList[ 'multi_edit' ] = array(
		'ui_context' => 'edit',
		'script'     => 'multi_edit.php',
);

$ViewList[ 'store_attribute' ] = array(
		'ui_context' => 'edit',
		'script'     => 'store_attribute.php',
);

$ViewList[ 'publish' ] = array(
		'ui_context' => 'edit',
		'script'     => 'publish.php',
);

$ViewList[ 'discard' ] = array(
		'ui_context' => 'edit',
		'script'     => 'discard.php',
);

$ViewList[ 'versions' ] = array(
		'ui_context' => 'edit',
		'script'     => 'versions.php',
);

$ViewList[ 'remove' ] = array(
		'ui_context' => 'edit',
		'script'     => 'remove.php',
);

$ViewList[ 'remove_object' ] = array(
	'ui_context' => 'edit',
	'script'     => 'remove_object.php',
);

$ViewList[ 'bookmark' ] = array(
	'script'     => 'bookmark.php',
	'ui_context' => 'administration',
);

$ViewList[ 'node_view_gui' ] = array(
	'script'     => 'node_view_gui.php',
	'ui_context' => 'administration',
	'functions'  => array( 'public' ),
);

$ParentClassID = array(
		'name'=> 'Parent_Class',
		'values'=> array(),
		'class' => 'eZContentClass',
		'function' => 'fetchList',
		'parameter' => array( 0, false, false, array( 'name' => 'asc' ) ),
);

$mimeTypes = array(
		'name'=> 'Mime_Types',
		'values'=> array(),
		'class' => 'MugoBootStrapAdminFunctions',
		'function' => 'getMimeTypesForPolicies',
		'parameter' => array(),
);

$FunctionList = array();
$FunctionList[ 'public' ] = array();
$FunctionList[ 'upload_files' ] = array(
		'parent_class' => $ParentClassID,
		'mime_types' => $mimeTypes,
);
