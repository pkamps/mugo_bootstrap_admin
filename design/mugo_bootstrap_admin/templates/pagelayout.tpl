<!DOCTYPE html>
<html lang="en">
{include uri='design:includes/pagelayout/head.tpl'}
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-3 affix left-col">
			{include uri='design:includes/pagelayout/left_col.tpl'}
		</div>
		<div class="col-md-9 col-md-offset-3">
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
							<button data-href={$edit_url|ezurl()} type="button" class="btn btn-default navbar-btn">{$draft.name|wash()}</button>
						</li>
					{/foreach}
				</ul>
			{/if}

			<ul class="nav navbar-nav navbar-right">
				<li>
					<button data-toggle="modal" data-target="#debug-output" type="button" class="btn btn-default navbar-btn">
						<i class="glyphicon glyphicon-record"></i>
					</button>
				</li>
			</ul>

		</div>
		
	</div>
</nav>
{include uri='design:includes/pagelayout/footer_script.tpl'}

<div id="debug-output" class="modal fade" data-keyboard="true">
	<div class="modal-dialog modal-max">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">Debug Output</h4>
			</div>
			<div class="modal-body">
				<!--DEBUG_REPORT-->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

</body>
