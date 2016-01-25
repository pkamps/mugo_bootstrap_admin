{def
	$can_create_classes = fetch( 'content', 'can_instantiate_class_list', hash(
		'parent_node', $node
	))
	$multi_edit = ezini( $node.class_identifier, 'MultiEdit', 'multiedit.ini' )
}

<div class="full">
	{node_view_gui content_node=$node view='preview'}

	{* node actions *}
	{def $previews = ezini( 'Previews', 'List', 'mugo_bootstrap_admin.ini' )}

	<div class="btn-toolbar" role="toolbar">
		<div class="btn-group" role="group">
			{if $multi_edit|count()}
				<div id="edit-button" class="btn-group">
					<button type="button" class="btn btn-primary" data-href={concat( '/content/edit/', $node.contentobject_id )|ezurl()}>Edit</button>
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
				<button type="button" class="btn btn-primary" data-href={concat( '/content/edit/', $node.contentobject_id )|ezurl()}>Edit</button>
			{/if}
		</div>
		<div id="view-button" class="btn-group">
			<button type="button" class="btn btn-default" data-layout="data">View</button>
			<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="caret"></span>
				<span class="sr-only">Toggle Dropdown</span>
			</button>
			<ul class="dropdown-menu">
				{foreach $previews as $key => $preview}
					<li><a data-layout="{$key}" href="#">{$preview}</a></li>
				{/foreach}
			</ul>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-default">Move</button>
		</div>
		<div class="btn-group">
			<button type="button" class="btn btn-default remove-button">Remove</button>
		</div>
	</div>
	<br>

	{* panels *}
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

	{include uri='design:includes/full/related.tpl' node=$node}
</div>

{* preview modal *}
<div class="modals">
	<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-max" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title pull-left" id="myModalLabel">
						Preview
					</h4>

					<div class="container text-center">
						<div class="col-xs-2">
							<select id="preview-selector" class="form-control">
								<option data-iframe-target={concat( 'content/view/data/', $node.node_id )|ezurl()} value="data">Data</option>
								{def
									$iframe_target = ''
									$iframe_default_size = ''
								}
								{foreach $previews as $key => $preview}
									{set
										$iframe_target = ezini( concat( 'Previews_', $key ), 'Url', 'mugo_bootstrap_admin.ini' )
										$iframe_default_size = ezini( concat( 'Previews_', $key ), 'DefaultSize', 'mugo_bootstrap_admin.ini' )
									}

									<option data-iframe-target="{$iframe_target}" data-default-size="{$iframe_default_size}" value="{$key}">{$preview}</option>
								{/foreach}
							</select>
						</div>
						<div class="col-xs-2">
							<select id="preview-size" class="form-control">
								<option value="extra-small-width">Extra small devices</option>
								<option value="small-width">Small devices</option>
								<option value="medium-width">Medium devices</option>
								<option value="large-width">Large devices</option>
							</select>
						</div>
					</div>
				</div>
				<div class="modal-body">
					<div id="iframe-wrapper" class="medium-width center-block">
						<iframe src="" width="100%" height="100%">
							Your browser does not support iframes. Please see this &lt;a href="/content/versionview/90/115/eng-US/site_access/site_origin"&gt;link&lt;/a&gt; instead.
						</iframe>
					</div>
				</div>
				<div class="modal-footer">
					<button id="open-in-new-window" type="button" class="btn btn-default">Open in new window</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	$(function()
	{ldelim}
		$( '#viewModal' ).previewmodal(
		{ldelim}
			targetVars:
			{ldelim}
				nodeId: '{$node.node_id}',
				contentObjectId: '{$node.contentobject_id}',
				nodeUrl: '{$node.url_alias}',
				versionNr: '{$node.object.current_version}',
			{rdelim},
		{rdelim});
	{rdelim});
	</script>
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