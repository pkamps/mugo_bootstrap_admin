<?php

class EditCaptions extends MultiEdit
{
    public function getRelatedObjects( $handleObjectId )
    {
        $return = array();

        $eZObj = eZContentObject::fetch( $handleObjectId );

        if( $eZObj )
        {
            // Adding construct object
            $return[] = $eZObj;

            $dataMap = $eZObj->attribute( 'data_map' );

            $content = $dataMap[ 'images' ]->attribute( 'content' );

            if( !empty( $content[ 'relation_list' ] ) )
            {
                foreach( $content[ 'relation_list' ] as $row )
                {
                    $return[] = eZContentObject::fetch( $row[ 'contentobject_id' ] );
                }
            }
        }

        return $return;
    }

    public function getTemplate()
    {
        return 'captions.tpl';
    }

}