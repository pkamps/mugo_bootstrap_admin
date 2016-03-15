<?php

$module = $Params[ 'Module' ];
$tpl    = eZTemplate::factory();
$content = '';
$limit = 200;

$value = $_REQUEST[ 'value' ];
$type = $_REQUEST[ 'type' ];

switch( $type )
{
	case 'view':
	{
		$module = eZModule::findModule( $value );

		if( $module )
		{
			$viewData = array();

			if( !empty( $module->Functions ) )
			{
				foreach( $module->Functions as $view )
				{
					$name = explode( '/', $view[ 'uri' ] )[2];

					$viewData[] = array(
						'title' => $name,
						'key' => $view[ 'uri' ],
						'folder' => false,
						'lazy' => false,
						'icon' => 'glyphicon icon-default',
						'href' => $view[ 'uri' ],
					);
				}
			}

			$content = json_encode( $viewData );
		}
	}
	break;

	case 'solr_filter':
	{
		$node = eZContentObjectTreeNode::fetch( $value );

		if( $node )
		{
			$dataMap = $node->attribute( 'data_map' );
			$query = $dataMap[ 'solr_filter' ]->attribute( 'content' );

			$tpl->setVariable( 'query', $query );
			$content = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/treemenu_search.tpl' );
		}
	}
	break;

	// including type 'node_id'
	default:
	{
		// special case for setup node
		if( $value == 48 )
		{
			$data = [];

			$moduleIni = eZINI::instance( 'module.ini' );
			$moduleNames = $moduleIni->variable( 'ModuleSettings', 'ModuleList' );

			foreach( $moduleNames as $identifier )
			{
				$module = eZModule::findModule( $identifier );
				// if module does not have a name
				$name = $module->Module[ 'name' ] ? $module->Module[ 'name' ] : $identifier;

				$data[ $name ] = array(
					'title' => $name,
					'key' => $identifier,
					'folder' => true,
					'lazy' => true,
					'icon' => 'glyphicon icon-default',
					'type' => 'view',
				);
			}

			ksort( $data, SORT_STRING );

			// remove keys
			foreach( $data as $entry )
			{
				$cleanData[] = $entry;
			}

			$content = json_encode( $cleanData );
		}
		else
		{
			$data = array();

			$parentNodeId = (int) $value;
			$parentNode = eZContentObjectTreeNode::fetch( $parentNodeId );
			$params = array(
				'parent_node_id' => $parentNodeId,
				'limit'=> 200,
				'sort_by' => $parentNode->attribute( 'sort_array' ),
			);
			$list = eZFunctionHandler::execute( 'content', 'list', $params );
			$listCount = eZFunctionHandler::execute( 'content', 'list_count', $params );

			foreach( $list as $node )
			{
				$isContainer = (boolean) $node->attribute( 'is_container' );

				$entry = array(
					'title' => $node->attribute( 'name' ),
					'key' => $node->attribute( 'node_id' ),
					'folder' => $isContainer,
					'lazy' => $isContainer,
					'icon' => 'glyphicon icon-default icon-' . $node->attribute( 'class_identifier' ),
					'node_id' => $node->attribute( 'node_id' ),
					'contentobject_id' => $node->attribute( 'contentobject_id' ),
					'href' => getLink( $node ),
				);

				$data[] = $entry;
			}

			$content = json_encode( $data );
		}
	}
}

/**
 * TODO: hack
 *
 * @param $node
 * @return string
 */
function getLink( $node )
{
	if( $node->attribute( 'class_identifier' ) == 'bookmark' )
	{
		$dataMap = $node->attribute( 'data_map' );

		if( $dataMap[ 'link' ]->attribute( 'has_content' ) )
		{
			$return = '/' . ltrim( $dataMap[ 'link' ]->attribute( 'content' ), '/' );
		}
	}
	else
	{
		$return = '/' . $node->attribute( 'url_alias' );
	}

	return $return;
}

echo $content;
eZExecution::cleanExit();
