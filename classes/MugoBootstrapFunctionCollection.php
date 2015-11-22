<?php

class MugoBootstrapFunctionCollection
{
    /**
     * @return array
     */
    static function groupedUserDrafts()
    {
        $return = array();

        $user = eZUser::currentUser();

        $fetchParameters = array(
            'status' => array(
                array( eZContentObjectVersion::STATUS_DRAFT )
            ),
            'creator_id' => $user->attribute( 'contentobject_id' ),
        );

        $versions = eZPersistentObject::fetchObjectList(
            eZContentObjectVersion::definition(),
            null,
            $fetchParameters
        );

        $flat = array();
        foreach( $versions as $version )
        {
            $flat[ $version->attribute( 'contentobject_id' ) ] = array(
                'version' => $version,
                'related' => array(),
            );
        }

        foreach( $flat as $id => $entry )
        {
            $eZObj = $entry[ 'version' ]->attribute( 'contentobject' );
            switch( $eZObj->attribute( 'class_identifier' ) )
            {
                case 'image':
                {
                    $revese_related_objects = $eZObj->reverseRelatedObjectList(
                        false,
                        0,
                        false,
                        array( 'AllRelations' => true )
                    );

                    foreach( $revese_related_objects as $rr_eZObj )
                    {
                        if( isset( $flat[ $rr_eZObj->attribute( 'id' ) ] ) )
                        {
                            $flat[ $rr_eZObj->attribute( 'id' ) ][ 'related' ][] = $entry[ 'version' ];
                            unset( $flat[ $eZObj->attribute( 'id' ) ] );
                        }
                    }
                }
            }
        }

        return array( 'result' => $flat );
    }
}