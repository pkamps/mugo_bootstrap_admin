<?php

class MugoBootStrapAdminFetchFunctions
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
                array(
                    eZContentObjectVersion::STATUS_DRAFT,
                    eZContentObjectVersion::STATUS_INTERNAL_DRAFT,
                )
            ),
            'creator_id' => $user->attribute( 'contentobject_id' ),
        );

        $versions = eZPersistentObject::fetchObjectList(
            eZContentObjectVersion::definition(),
            null,
            $fetchParameters
        );

        $return = array();
        foreach( $versions as $version )
        {
            $return[ $version->attribute( 'contentobject_id' ) ] = array(
                'version' => $version,
                'related' => array(),
            );
        }

        foreach( $return as $id => $entry )
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
                        if( isset( $return[ $rr_eZObj->attribute( 'id' ) ] ) )
                        {
                            $return[ $rr_eZObj->attribute( 'id' ) ][ 'related' ][] = $entry[ 'version' ];
                            unset( $return[ $eZObj->attribute( 'id' ) ] );
                        }
                    }
                }
            }
        }

        return array( 'result' => $return );
    }

    /**
     * Returns an array of mime types.
     *
     * @param eZContentObjectTreeNode $parent_node
     * @return array
     */
    static function canUploadMimeTypes( $parent_node )
    {
        $return = false;

        $user = eZUser::currentUser();

        $accessResult = $user->hasAccessTo( 'admin_edit' , 'upload_files' );

        switch( $accessResult[ 'accessWord' ] )
        {
            case 'yes':
            {
                $return = MugoBootStrapAdminFunctions::getMimeTypes();
            }
                break;

            case 'no':
            {
                // still false
            }
                break;

            case 'limited':
            {
                $return = self::matches_limitation( $accessResult[ 'policies' ], $parent_node );
            }
                break;

            default:
        }

        return array( 'result' => $return );
    }

    private static function matches_limitation( $policies, $parent_node )
    {
        $return = false;

        if( !empty( $policies ) )
        {
            foreach( $policies as $policy )
            {
                if( !empty( $policy ) )
                {
                    $matchLimitations = true;

                    // assign role by subtree
                    if( !empty( $policy[ 'User_Subtree' ] ) )
                    {
                        $path = $parent_node->attribute( 'path_string' );

                        $found = false;
                        foreach( $policy[ 'User_Subtree' ] as $policyPath )
                        {
                            if( strpos( $path, $policyPath ) !== false )
                            {
                                $found = true;
                                break;
                            }
                        }

                        $matchLimitations = $found;
                    }

                    // parent content class limitation
                    if( $matchLimitations && !empty( $policy[ 'Parent_Class' ] ) )
                    {
                        $class_id = $parent_node->attribute( 'object' )->attribute( 'contentclass_id' );
                        $matchLimitations = in_array( $class_id, $policy[ 'Parent_Class' ] );
                    }

                    if( $matchLimitations )
                    {
                        $return = $policy[ 'Mime_Types' ];
                    }
                }
            }
        }

        return $return;
    }
}