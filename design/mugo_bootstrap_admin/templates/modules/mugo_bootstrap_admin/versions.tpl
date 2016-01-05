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
                <td>{$status_names[ $version.status ]}</td>
                <td>{$version.creator.name|wash()}</td>
            </tr>
        {/foreach}
    </tbody>
</table>