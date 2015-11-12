<!DOCTYPE html>
<html lang="en">
{include uri='design:includes/pagelayout/head.tpl'}
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-3">
			{include uri='design:includes/pagelayout/left_col.tpl'}
		</div>
		<div class="col-md-9">
			{include uri='design:includes/pagelayout/top_path.tpl'}
			{$module_result.content}
		</div>
	</div>
</div>

<nav class="navbar navbar-default navbar-fixed-bottom">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
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
			{def $drafts = fetch( 'content', 'draft_version_list' )}

			{if $drafts}
				<ul class="nav navbar-nav">
					{def $edit_url = ''}
					{foreach $drafts as $draft}
						{set $edit_url = concat( 'content/edit/', $draft.contentobject_id, '/', $draft.version )}
						<li class="active">
							<button data-target={$edit_url|ezurl()} type="button" class="btn btn-default navbar-btn">{$draft.name|wash()}</button>
						</li>
					{/foreach}
				</ul>
			{/if}
		</div>
		
	</div>
</nav>
{include uri='design:includes/pagelayout/footer_script.tpl'}
</body>
