<?php

/**
 * $_REQUEST
 *
 * objectobject_id
 * type
 *
 */

$multiEdit = MultiEdit::factory( $_REQUEST[ 'type' ] );

$objId = (int)$_REQUEST[ 'contentobject_id' ];

if( $objId )
{
    $objects = $multiEdit->getRelatedObjects( $objId );

    $tpl = eZTemplate::factory();
    $tpl->setVariable( 'construct_id', $objId );
    $tpl->setVariable( 'versions', $multiEdit->getDraftVersions( $objects ) );

    $Result = array();
    $Result[ 'content' ] = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/multi_edit/'. $multiEdit->getTemplate() );

}

