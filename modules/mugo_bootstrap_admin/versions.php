<?php

$objectId = $_REQUEST[ 'contentobjectid' ];

if( $objectId )
{
    $eZObj = eZContentObject::fetch( $objectId );

    if( $eZObj )
    {
        $versions = $eZObj->versions();

        $tpl = eZTemplate::factory();
        $tpl->setVariable( 'versions', $versions );
        $content = $tpl->fetch( 'design:modules/mugo_bootstrap_admin/versions.tpl' );
    }
}

echo $content;

eZExecution::cleanExit();
