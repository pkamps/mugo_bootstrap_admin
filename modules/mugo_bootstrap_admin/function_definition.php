<?php
$FunctionList = array();

$FunctionList[ 'grouped_drafts' ] = array(
	'name' => 'Drafts Grouped',
	'call_method' => array(
		'class' => 'MugoBootstrapFunctionCollection',
		'method' => 'groupedUserDrafts' ),
	'parameter_type' => 'standard',
	'parameters' => array(),
);
