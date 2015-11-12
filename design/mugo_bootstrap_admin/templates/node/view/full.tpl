<h1>{$node.name|wash()}</h1>

<section>
	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="active">
			<a href="#tab-details" aria-controls="messages" role="tab" data-toggle="tab">Details</a>
		</li>
		<li role="presentation">
			<a href="#tab-preview" aria-controls="profile" role="tab" data-toggle="tab">Preview</a>
		</li>
	</ul>

	<div class="tab-content">
		<div role="tabpanel" class="tab-pane active" id="tab-details">
			{include uri='design:details.tpl'}
		</div>
		<div role="tabpanel" class="tab-pane" id="tab-preview">
			{include uri='design:preview.tpl'}
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