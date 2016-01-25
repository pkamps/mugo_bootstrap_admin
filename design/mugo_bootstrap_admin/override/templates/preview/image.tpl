<div class="clearfix">
	<div class="pull-left">
		{if $node.data_map.images.has_content}
			{attribute_view_gui
				attribute=$node.data_map.images
				css_class='img-thumbnail'
				image_alias='standard_120x80'
			}
		{/if}
	</div>
	<div class="pull-left" style="margin-left: 20px">
		<h1>{$node.name|wash()} <small>{$node.class_name|wash()}</small></h1>
		<p>
			Last update <i>{$node.object.current.modified|l10n( 'datetime' )}</i>,
			<a href="#">{$node.object.current.creator.name|wash()}</a>
		</p>
	</div>
</div>
