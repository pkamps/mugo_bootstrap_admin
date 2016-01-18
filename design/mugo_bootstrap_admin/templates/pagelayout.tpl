<!DOCTYPE html>
<html lang="en">
{include uri='design:includes/pagelayout/head.tpl'}
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-3 affix left-col">
			{include uri='design:includes/pagelayout/left_col.tpl'}
		</div>
		<div class="col-md-9 col-md-offset-3">
			{include uri='design:includes/pagelayout/top_path.tpl'}
			{$module_result.content}
		</div>
	</div>
</div>

{include uri='design:includes/pagelayout/task_bar.tpl'}
{include uri='design:includes/pagelayout/footer_script.tpl'}
{include uri='design:includes/pagelayout/modals.tpl'}

</body>
