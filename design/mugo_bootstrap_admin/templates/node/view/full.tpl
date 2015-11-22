<div class="full">
	<h1>{$node.name|wash()} <small>{$node.class_name|wash()}</small></h1>
	<p>
		Last update <i>{$node.object.current.modified|l10n( 'datetime' )}</i>,
		<a href="#">{$node.object.current.creator.name|wash()}</a>
		<span class="pull-right">Languages: English</span>
	</p>

	<div class="btn-toolbar" role="toolbar">
		<div class="btn-group" role="group">
			<button type="button" class="btn btn-primary" data-href={concat( '/content/edit/', $node.contentobject_id )|ezurl()} >Edit</button>
		</div>
		<div id="view-button" class="btn-group">
			<button type="button" class="btn btn-default">View</button>
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="caret"></span>
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<ul class="dropdown-menu">
				<li><a href="#">data</a></li>
				<li><a href="#">public</a></li>
				<li><a href="#">mobile</a></li>
			</ul>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-default">Move</button>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-default">Remove</button>
		</div>
		<div class="btn-group" role="group">
			<button data-href={concat( '/content/history/', $node.contentobject_id )|ezurl()} type="button" class="btn btn-default">Manage Versions</button>
		</div>
	</div>
	<br>

	<section>
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingOne">
					<h4 class="panel-title">
						<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
							Object states
						</a>
					</h4>
				</div>
				<div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
					<div class="panel-body">
						{content_view_gui content_object=$node.object view="content_states"}
					</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingThree">
					<h4 class="panel-title">
						<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
							Details
						</a>
					</h4>
				</div>
				<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
					<div class="panel-body">
						{include uri='design:details.tpl'}
					</div>
				</div>
			</div>
		</div>
	</section>

	<section>
		{def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id ) )}

		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active">
				<a href="#tab-subitems" aria-controls="messages" role="tab" data-toggle="tab">Sub Items <span class="badge">215</span></a>
			</li>
			<li role="presentation">
				<a href="#tab-relations" aria-controls="profile" role="tab" data-toggle="tab">Relations <span class="badge">3</span></a>
			</li>
			<li role="presentation">
				<a href="#tab-locations" aria-controls="profile" role="tab" data-toggle="tab">Locations <span class="badge">1</span></a>
			</li>
		</ul>

		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tab-subitems">
				<br>

				<div class="btn-toolbar" role="toolbar">
					<div class="btn-group" role="group">
						<button type="button" class="btn btn-default">Select</button>
						<button type="button" class="btn btn-primary">Create new</button>
						<button type="button" class="btn btn-default">Change order</button>
					</div>
				</div>

				{include uri='design:includes/nodes_table.tpl' entries=$children}
			</div>

			<div role="tabpanel" class="tab-pane" id="tab-relations">
				{include uri='design:includes/relations.tpl'}
			</div>
			<div role="tabpanel" class="tab-pane" id="tab-locations">
				{include uri='design:locations.tpl'}
			</div>
		</div>

	</section>
</div>

<div class="modals">
	<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-max" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">Preview</h4>
				</div>
				<div class="modal-body">
					<iframe src="" width="100%" height="800">
						Your browser does not support iframes. Please see this &lt;a href="/content/versionview/90/115/eng-US/site_access/site_origin"&gt;link&lt;/a&gt; instead.
					</iframe>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
</div>

{*
<section>
	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="active">
			<a href="#tab-info" aria-controls="messages" role="tab" data-toggle="tab">Info</a>
		</li>
		<li role="presentation">
			<a href="#tab-details" aria-controls="messages" role="tab" data-toggle="tab">Details</a>
		</li>
		<li role="presentation">
			<a href="#tab-preview" aria-controls="profile" role="tab" data-toggle="tab">Preview</a>
		</li>
	</ul>

	<div class="tab-content">
		<div role="tabpanel" class="tab-pane active" id="tab-info">
			{include uri='design:includes/info.tpl'}
		</div>
		<div role="tabpanel" class="tab-pane" id="tab-details">
			{include uri='design:details.tpl'}
		</div>
		<div role="tabpanel" class="tab-pane" id="tab-preview">
			{include uri='design:preview.tpl'}
		</div>
	</div>
</section>
*}