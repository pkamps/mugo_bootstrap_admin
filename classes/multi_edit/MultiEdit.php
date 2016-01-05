<?php

class MultiEdit
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

    public function getDraftVersions( $objects )
    {
        $return = array();

        $user = eZUser::currentUser();

        foreach( $objects as $object )
        {
            // If this user already has a draft in this language
            $filters = array(
                'contentobject_id' => $object->attribute( 'id' ),
                'status' => array( array( eZContentObjectVersion::STATUS_DRAFT, eZContentObjectVersion::STATUS_INTERNAL_DRAFT ) ),
                //'version' => array( '>', $sourceVersionID ),
                //'initial_language_id' => $sourceVersionLanguageID,
                'creator_id' => $user->attribute( 'contentobject_id' ),
            );

            $existingDrafts = eZContentObjectVersion::fetchFiltered( $filters, 0, 1 );

            if( !empty( $existingDrafts ) )
            {
                $return[] = $existingDrafts[0];
            }
            else
            {
                $return[] = $object->createNewVersion( false, true );
            }
        }

        return $return;
    }

    public function getTemplate()
    {
        return 'generic.tpl';
    }

    public static function factory( $context )
    {
        $class = class_exists( $context ) ? $context : 'MultiEdit';

        return new $class;
    }
}
