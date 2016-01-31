{*
   versions
*}

{def $status_names = array(
    'Draft'|i18n( 'design/admin/content/history' ),
    'Published'|i18n( 'design/admin/content/history' ),
    'Pending'|i18n( 'design/admin/content/history' ),
    'Archived'|i18n( 'design/admin/content/history' ),
    'Rejected'|i18n( 'design/admin/content/history' ),
    'Untouched draft'|i18n( 'design/admin/content/history' ),
    'Repeat'|i18n( 'design/standard/content/history' ),
    'Queued'|i18n( 'design/standard/content/history' ),
)}

{def $background_map = hash(
    0, 'label-success',
    1, 'label-primary',
    2, 'label-warning',
    3, 'label-info',
    4, 'label-danger',
    5, 'label-success',
    6, 'label-default',
    7, 'label-warning',
)}

<table class="table">
    <thead>
        <tr>
            <td>Nr</td>
            <td>Status</td>
            <td>Creator</td>
        </tr>
    </thead>
    <tbody>
        {foreach $versions as $version}
            <tr>
                <td>{$version.version}</td>
                <td><span class="label {first_set( $background_map[ $version.status ], '' )}">{$status_names[ $version.status ]}</span></td>
                <td>{$version.creator.name|wash()}</td>
            </tr>
        {/foreach}
    </tbody>
</table>