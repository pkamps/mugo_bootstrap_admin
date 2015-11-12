<?php

$module = $Params[ 'Module' ];
$tpl    = eZTemplate::factory();
$content = '';

$parent_node_id = (int) $Params[ 'parent_node_id' ];

if( $parent_node_id )
{
	// special case for setup node
	if( $parent_node_id == 48 )
	{
		$moduleData = array();

		$moduleIni = eZINI::instance( 'module.ini' );

		$moduleNames = $moduleIni->variable( 'ModuleSettings', 'ModuleList' );
		sort( $moduleNames );

		foreach( $moduleNames as $identifier )
		{
			$module = eZModule::findModule( $identifier );

			$viewData = array();

			if( !empty( $module->Functions ) )
			{
				foreach( $module->Functions as $view )
				{
					$viewData[] = array(
						'name' => explode( '/', $view[ 'uri' ] )[2],
						'url' => $view[ 'uri' ],
					);
				}
			}

			$moduleDataEntry[] = array(
				'identifier' => $identifier,
				'name' => $module->Module[ 'name' ],
				'views' => $viewData,
			);
		}
		$tpl->setVariable( 'modules', $moduleDataEntry );
		$content = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/treemenu_modules.tpl' );
	}
	else
	{
		$tpl->setVariable( 'parent_node_id', $parent_node_id );
		$content = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/treemenu_list.tpl' );
	}
}

$Result[ 'content' ] = $content;
$Result[ 'pagelayout' ] = false;