<div class="container-fluid">
	{foreach $node.data_map as $attribute}
		<div class="row">
			<div class="col-md-12">
				<h2>{$attribute.contentclass_attribute_name|wash()}</h2>
				<div>{attribute_view_gui attribute=$attribute}</div>
			</div>
		</div>
	{/foreach}
</div>
