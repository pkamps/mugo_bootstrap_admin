<?php

class EditCaptions extends MultiEdit
{
    public function getRelatedObjects( $handleObjectId )
    {
        $return = array();

        $eZObj = eZContentObject::fetch( $handleObjectId );
        $parentNode = $eZObj->attribute( 'main_node' );

        $children = $parentNode->attribute( 'children' );

        foreach( $children as $child )
        {
            $return[] = $child->attribute( 'object' );
        }

        return $return;
    }

    public function getTemplate()
    {
        return 'captions.tpl';
    }

}