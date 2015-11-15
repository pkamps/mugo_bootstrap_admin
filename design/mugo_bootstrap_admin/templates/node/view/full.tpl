<h1>{$node.name|wash()} <small>{$node.class_name|wash()}</small></h1>
<p>
	Last update <i>{$node.object.current.modified|l10n( 'datetime' )}</i>,
	<a href="#">{$node.object.current.creator.name|wash()}</a>
	<span class="pull-right">Languages: English</span>
</p>

<div class="btn-toolbar" role="toolbar">
	<div class="btn-group" role="group">
		<button type="button" class="btn btn-primary">Edit</button>
		<button type="button" class="btn btn-default">Move</button>
		<button type="button" class="btn btn-default">Remove</button>
	</div>
	<div class="btn-group" role="group">
		<button type="button" class="btn btn-default">Manage Versions</button>
	</div>
</div>
<br><br>

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
			<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
				<div class="panel-body">
					{content_view_gui content_object=$node.object view="content_states"}
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading" role="tab" id="headingTwo">
				<h4 class="panel-title">
					<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						Locations
					</a>
				</h4>
			</div>
			<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
				<div class="panel-body">
					{include uri='design:locations.tpl'}
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
			<a href="#tab-subitems" aria-controls="messages" role="tab" data-toggle="tab">Sub Items</a>
		</li>
		<li role="presentation">
			<a href="#tab-relations" aria-controls="profile" role="tab" data-toggle="tab">Relations</a>
		</li>
	</ul>

	<div class="tab-content">
		<div role="tabpanel" class="tab-pane active" id="tab-subitems">
			<table class="table">
				{foreach $children as $child}
					<tr>
						<td><a href={$child.url_alias|ezurl()}>{$child.name|wash()}</a></td>
					</tr>
				{/foreach}
			</table>
		</div>

		<div role="tabpanel" class="tab-pane" id="tab-relations">
			{include uri='design:relations.tpl'}
		</div>
	</div>

</section>

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
