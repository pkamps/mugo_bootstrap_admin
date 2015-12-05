<?php
$FunctionList = array();

$FunctionList[ 'grouped_drafts' ] = array(
	'name' => 'Drafts Grouped',
	'call_method' => array(
		'class' => 'MugoBootStrapAdminFetchFunctions',
		'method' => 'groupedUserDrafts' ),
	'parameter_type' => 'standard',
	'parameters' => array(),
);

$FunctionList[ 'can_upload_mime_types' ] = array(
		'name' => 'List of mime types user can upload',
		'call_method' => array(
				'class' => 'MugoBootStrapAdminFetchFunctions',
				'method' => 'canUploadMimeTypes'
		),
		'parameter_type' => 'standard',
		'parameters' => array(
				array(
						'name'     => 'parent_node',
						'type'     => 'object',
						'required' => true
				),
		)
);