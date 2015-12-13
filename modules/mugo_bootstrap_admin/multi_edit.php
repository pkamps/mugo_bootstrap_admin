<?php

/**
 * $_REQUEST
 *
 * objectobject_ids[]
 * objectobject_id
 * type
 *
 */

if( isset( $_REQUEST[ 'publish' ] ) || isset( $_REQUEST[ 'discard' ] ) )
{
    foreach( $data as $version )
    {
        if( isset( $_REQUEST[ 'publish' ] ) )
        {
            eZOperationHandler::execute(
                'content',
                'publish',
                array(
                    'object_id' =>$version->attribute( 'contentobject_id' ),
                    'version' => $version->attribute( 'version' ),
                )
            );
        }
        else
        {
            $version->removeThis();
        }
    }

    // redirect back
    $redirectNodeId = (int)$_REQUEST[ 'redirect_node_id' ];
    $redirectNodeId = $redirectNodeId ? $redirectNodeId : 2;


    $module = $Params[ 'Module' ];
    $module->redirectTo( '/content/view/full/' . $redirectNodeId );
}
else
{
    $multiEdit = MultiEdit::factory( $_REQUEST[ 'type' ] );

    $objId = (int)$_REQUEST[ 'contentobject_id' ];

    if( $objId )
    {
        $objects = $multiEdit->getRelatedObjects( $objId );
    }
    else
    {
        if( !empty( $_REQUEST[ 'contentobject_ids' ] ) )
        {
            foreach( $_REQUEST[ 'contentobject_ids' ] as $id )
            {
                $objects[] = eZContentObject::fetch( $id );
            }
        }
    }

    if( !empty( $objects ) )
    {
        $tpl = eZTemplate::factory();
        $tpl->setVariable( 'redirect_node_id', (int)$_REQUEST[ 'redirect_node_id'] );
        $tpl->setVariable( 'versions', $multiEdit->getDraftVersions( $objects ) );

        $Result = array();
        $Result[ 'content' ] = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/multi_edit/'. $multiEdit->getTemplate() );
    }
}

