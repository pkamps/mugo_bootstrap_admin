{def $user = fetch( 'user', 'current_user' )}

<ul id="left-column-tabs" class="nav nav-tabs" role="tablist">
	<li role="presentation" class="active">
		<a href="#tab-bookmarks" aria-controls="profile" role="tab" data-toggle="tab">Bookmarks</a>
	</li>
	<li role="presentation">
		<a href="#tab-all" aria-controls="home" role="tab" data-toggle="tab">All</a>
	</li>
	<li role="presentation">
		<a href="#tab-search" aria-controls="messages" role="tab" data-toggle="tab">Search</a>
	</li>
</ul>

<div class="tab-content">
	<div role="tabpanel" class="tab-pane active" id="tab-bookmarks">
		<div class="tree">
			<ul>
				<li class="container" data-value="{$user.contentobject.main_node_id}" data-open="1">
					<span class="icon-default icon-user"></span>
					{$user.contentobject.name|wash()}
				</li>
			</ul>
		</div>
	</div>

	<div role="tabpanel" class="tab-pane" id="tab-all">
		<div class="tree">
			<ul>
				<li class="container" data-value="1" data-open="1">
					<span class="icon-folder"></span>
					All
				</li>
			</ul>
		</div>
	</div>

	<div role="tabpanel" class="tab-pane" id="tab-search">
		<div class="tree">
			<ul>
				<li class="container" data-value="0" data-open="0">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search for...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button">Go!</button>
						</span>
					</div>
				</li>
			</ul>
		</div>
		<div class="tree">
			<ul>
				<li class="container" data-value="0" data-open="0">
					<span class="icon-folder-open"></span>
					Saved Searches
				</li>
			</ul>
		</div>
	</div>
</div>

{literal}
<script>
$(function()
{
	$( '.tree' ).treemenu(
	{
		baseUrl : eZBaseUrl,
	});

	$( '#left-column-tabs' ).remembertab();
});
</script>
{/literal}