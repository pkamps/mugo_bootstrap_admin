{*
   INPUT
		node
*}

<section class="related">
	{def $children = array()}
	{if $node.is_container}
		{set $children = fetch( 'content', 'list', hash(
			'parent_node_id', $node.node_id,
			'limit', 200,
		) ) }
	{/if}

	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="active">
			<a href="#tab-subitems" aria-controls="messages" role="tab" data-toggle="tab">Sub Items <span class="badge">{$children|count()}</span></a>
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
			{if $node.is_container}
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
			{/if}
		</div>

		<div role="tabpanel" class="tab-pane" id="tab-relations">
			{include uri='design:includes/relations.tpl'}
		</div>
		<div role="tabpanel" class="tab-pane" id="tab-locations">
			{include uri='design:locations.tpl'}
		</div>
	</div>

</section>