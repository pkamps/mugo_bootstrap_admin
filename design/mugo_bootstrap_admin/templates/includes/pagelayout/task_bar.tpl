{def $grouped_drafts = fetch( 'mugo_bootstrap_admin', 'grouped_drafts' )}

<nav class="navbar navbar-default navbar-fixed-bottom">
    <div class="container-fluid">
        {* Brand and toggle get grouped for better mobile display *}
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">My drafts:</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            {if $grouped_drafts}
                {def $edit_url = ''}
                {foreach $grouped_drafts as $group}
                    {set $edit_url = concat( 'content/edit/', $group.version.contentobject_id, '/', $group.version.version )}

                    {if $group.related|count()}
                        <div class="btn-group dropup">
                            <button data-href={$edit_url|ezurl()} type="button" class="btn btn-default">
                                {* $group.version.object.class_identifier|class_icon( small, $group.version.object.class_name ) *}
                                {$group.version.name|wash()}
                            </button>
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul class="dropdown-menu">
                                {foreach $group.related as $related_version}
                                    {set $edit_url = concat( 'content/edit/', $related_version.contentobject_id, '/', $related_version.version )}
                                    <li>
                                        {* $related_version.class_identifier|class_icon( small, $related_version.class_name ) *}
                                        <a href={$edit_url|ezurl()}>{$related_version.name|wash()}</a>
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                    {else}
                        <button data-href={$edit_url|ezurl()} type="button" class="draft btn btn-default navbar-btn">
                            {$group.version.name|wash()}
                        </button>
                    {/if}
                {/foreach}
            {/if}

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <button data-toggle="modal" data-target="#debug-output" type="button" class="btn btn-default navbar-btn">
                        <i class="glyphicon glyphicon-gift"></i>
                    </button>
                </li>
            </ul>

        </div>

    </div>
</nav>
