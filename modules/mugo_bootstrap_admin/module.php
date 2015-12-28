<?php

$Module = array( 'name' => 'Mugo Bootstrap Admin' );

$ViewList = array();
$ViewList[ 'treemenu_list' ] = array(
		'script' => 'treemenu_list.php',
		'params' => array( 'value', 'type' ),
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
$FunctionList[ 'upload_files' ] = array(
		'parent_class' => $ParentClassID,
		'mime_types' => $mimeTypes,
);