{def
	$can_create_classes = fetch( 'content', 'can_instantiate_class_list', hash(
		'parent_node', $node
	))
	$multi_edit = ezini( $node.class_identifier, 'MultiEdit', 'multiedit.ini' )
}

<div class="full">
	{* node overview *}
	<h1>{$node.name|wash()} <small>{$node.class_name|wash()}</small></h1>
	<p>
		Last update <i>{$node.object.current.modified|l10n( 'datetime' )}</i>,
		<a href="#">{$node.object.current.creator.name|wash()}</a>
		<span class="pull-right">Languages: English</span>
	</p>

	{* node actions *}
	<div class="btn-toolbar" role="toolbar">
		<div class="btn-group" role="group">
			{if $multi_edit|count()}
				<div id="edit-button" class="btn-group">
					<button type="button" class="btn btn-primary">Edit</button>
					<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<span class="caret"></span>
						<span class="sr-only">Toggle Dropdown</span>
					</button>
					<ul class="dropdown-menu">
						{foreach $multi_edit as $key => $value}
							<li><a href={concat( '/mugo_bootstrap_admin/multi_edit?type=', $key, '&contentobject_id=', $node.contentobject_id )|ezurl()}>{$value|wash()}</a></li>
						{/foreach}
					</ul>
				</div>
			{else}
				<button type="button" class="btn btn-primary" data-href={concat( '/content/edit/', $node.contentobject_id )|ezurl()} >Edit</button>
			{/if}
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
		{*
		<div class="btn-group" role="group">
			<button data-href={concat( '/content/history/', $node.contentobject_id )|ezurl()} type="button" class="btn btn-default">Manage Versions</button>
		</div>
		*}
	</div>
	<br>

	<section>
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingOne">
					<h4 class="panel-title">
						<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
							States
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
				<div class="panel-heading" role="tab" id="headingTwo">
					<h4 class="panel-title">
						<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
							Details
						</a>
					</h4>
				</div>
				<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					<div class="panel-body">
						{include uri='design:details.tpl'}
					</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading" role="tab" id="headingThree">
					<h4 class="panel-title">
						<a id="show-versions" class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
							Versions
						</a>
					</h4>
				</div>
				<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
					<div class="panel-body">
						loading...
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

				<form name="children" method="post" action={'content/action'|ezurl}>
					<input type="hidden" name="NodeID" value="{$node.node_id}" />
					<input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />
					<input type="hidden" name="ClassID" value="" />

					<div class="btn-toolbar" role="toolbar">
						<div class="btn-group">
							<button type="button" class="btn btn-default dropdown-toggle btn-primary" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								Create new <span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								{foreach $can_create_classes as $class}
									<li>
										<a href="#" data-handle="createnew" data-classid="{$class.id}">
											{$class.name|wash()}
										</a>
									</li>
								{/foreach}
							</ul>
						</div>
						{def $mime_types = fetch( 'mugo_bootstrap_admin', 'can_upload_mime_types', hash(
							'parent_node', $node,
						))}
						{if $mime_types|count()}
							<div class="btn-group" role="group">
								<div id="upload-files">
									<button type="button" class="btn btn-default">Upload files</button>
									<input class="hidden" type="file" multiple="multiple" accept="{$mime_types|implode(',')}" />
								</div>
							</div>
							<script>
							{literal}
							$(function()
							{
								$( '#upload-files' ).uploadfilesbutton(
								{
									baseUrl: eZBaseUrl,
								});
							});
							{/literal}
							</script>
						{/if}
						<div class="btn-group" role="group">
							<button type="button" class="btn btn-default">Select</button>
							<button type="button" class="btn btn-default">Change order</button>
						</div>
					</div>
				</form>

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