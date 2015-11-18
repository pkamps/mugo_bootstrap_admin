<ul class="nav nav-tabs" role="tablist">
	<li role="presentation" class="active">
		<a href="#tab-all" aria-controls="home" role="tab" data-toggle="tab">All</a>
	</li>
	<li role="presentation">
		<a href="#tab-bookmarks" aria-controls="profile" role="tab" data-toggle="tab">Bookmarks</a>
	</li>
	<li role="presentation">
		<a href="#tab-search" aria-controls="messages" role="tab" data-toggle="tab">Search</a>
	</li>
</ul>

<div class="tab-content">
	<div role="tabpanel" class="tab-pane active" id="tab-all">
		<div class="tree">
			<ul>
				<li class="container" data-node-id="1" data-open="1">
					<span><i class="icon-folder-open"></i>All</span>
				</li>
			</ul>
		</div>
	</div>

	<div role="tabpanel" class="tab-pane" id="tab-bookmarks">
		bookmarks
	</div>

	<div role="tabpanel" class="tab-pane" id="tab-search">
		search
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
});
</script>
{/literal}