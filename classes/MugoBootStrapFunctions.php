<?php

class MugoBootStrapAdminFunctions
{
    /**
     * @return array
     */
    static function getMimeTypesForPolicies()
    {
        $return = array();

        $mimeTypes = self::getMimeTypes();

        if( !empty( $mimeTypes ) )
        {
            foreach( $mimeTypes as $mimeType )
            {
                $return[] = array(
                    'name' => $mimeType,
                    'id' => $mimeType,
                );
            }
        }

        return $return;
    }

    /**
     * Get all mime types configured in upload.ini
     *
     * @return array
     */
    static function getMimeTypes()
    {
        $settings = eZINI::instance( 'upload.ini' );

        $mimeTypeSetting = $settings->variable( 'CreateSettings', 'MimeClassMap' );

        $mimeTypes = array_keys( $mimeTypeSetting );

        //Handle mime type groups
        foreach( $mimeTypes as $index => $mimeType )
        {
            if( !strpos( $mimeType, '/' ) )
            {
                $mimeTypes[ $index ] = $mimeType . '/*';
            }
        }

        sort( $mimeTypes );

        return $mimeTypes;
    }
}
