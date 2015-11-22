{*
    entries:
*}

{if is_unset( $entries )}
    {def $entries = array()}
{/if}

<table class="table">
    <thead>
        <tr>
            <td style="width: 20px;"></td>
            <td style="width: 40px;"></td>
            <td>Name</td>
            <td>Type</td>
        </tr>
    </thead>
    <tbody>
    {foreach $entries as $entry}
        <tr>
            <td><input type="checkbox" /></td>
            <td>
                <div class="btn-group">
                    <button class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" type="button">
                        <i class="glyphicon glyphicon-cog"></i>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a href={concat( '/content/edit/', $entry.contentobject_id )|ezurl()}>Edit</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">Delete</a></li>
                    </ul>
                </div>
            </td>
            <td>
                {$entry.class_identifier|class_icon( small, $entry.class_name )}
                <a href={$entry.url_alias|ezurl()}>{$entry.name|wash()}</a>
            </td>
            <td>{$entry.class_name}</td>
        </tr>
    {/foreach}
    </tbody>
</table>
