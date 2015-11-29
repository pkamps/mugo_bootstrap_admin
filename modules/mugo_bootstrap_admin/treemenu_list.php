<?php

$module = $Params[ 'Module' ];
$tpl    = eZTemplate::factory();
$content = '';

$value = $Params[ 'value' ];
$type = $Params[ 'type' ];

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

					$viewData[ $name ] = $view[ 'uri' ];
				}
			}

			$tpl->setVariable( 'views', $viewData );
			$content = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/treemenu_views.tpl' );
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
			$moduleData = array();

			$moduleIni = eZINI::instance( 'module.ini' );
			$moduleNames = $moduleIni->variable( 'ModuleSettings', 'ModuleList' );

			foreach( $moduleNames as $identifier )
			{
				$module = eZModule::findModule( $identifier );
				// if module does not have a name
				$name = $module->Module[ 'name' ] ? $module->Module[ 'name' ] : $identifier;
				$moduleData[ $name ] = $identifier;
			}

			ksort( $moduleData, SORT_STRING );

			$tpl->setVariable( 'modules', $moduleData );
			$content = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/treemenu_modules.tpl' );
		}
		else
		{
			$tpl->setVariable( 'parent_node_id', $value );
			$content = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/treemenu_list.tpl' );
		}
	}
}

$Result[ 'content' ] = $content;
$Result[ 'pagelayout' ] = false;