<?php

$return = true;

$attributeId = (int) $_REQUEST[ 'attribute_id' ];
$versionId = (int) $_REQUEST[ 'version_id' ];
$content = $_REQUEST[ 'data' ];

if( $attributeId && $versionId )
{
    $attribute = eZContentObjectAttribute::fetch( $attributeId, $versionId );

    switch( $attribute->attribute( 'data_type_string' ) )
    {
        case 'ezxmltext':
        {
            if ( eZOEXMLInput::browserSupportsDHTMLType() === 'Trident' ) // IE
            {
                $content = str_replace( "\t", '', $content);
            }

            $parser = new eZOEInputParser();
            $document = $parser->process( $content );

            // Remove last empty paragraph (added in the output part)
            $parent = $document->documentElement;
            $lastChild = $parent->lastChild;
            while( $lastChild && $lastChild->nodeName !== 'paragraph' )
            {
                $parent = $lastChild;
                $lastChild = $parent->lastChild;
            }

            if ( $lastChild && $lastChild->nodeName === 'paragraph' )
            {
                $textChild = $lastChild->lastChild;
                // $textChild->textContent == "�" : string(2) whitespace in Opera
                if ( !$textChild ||
                    ( $lastChild->childNodes->length == 1 &&
                        $textChild->nodeType == XML_TEXT_NODE &&
                        ( $textChild->textContent == "�" || $textChild->textContent == ' ' || $textChild->textContent == '' || $textChild->textContent == '&nbsp;' ) ) )
                {
                    $parent->removeChild( $lastChild );
                }
            }

            $xmlString = eZXMLTextType::domString( $document );

            $attribute->setAttribute( 'data_text', $xmlString );
            $attribute->setValidationLog( $parser->Messages );
            $attribute->store();
        }
            break;

        default:
        {
            $attribute->fromString( $content );
            $attribute->store();
        }
    }
}

header( 'Content-type: application/json' );
echo json_encode( $return );

eZExecution::cleanExit();
