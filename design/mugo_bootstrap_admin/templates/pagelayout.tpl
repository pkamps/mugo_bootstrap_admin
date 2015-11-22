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

<div id="debug-output" class="modal fade" data-keyboard="true">
	<div class="modal-dialog modal-max">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">Debug Output</h4>
			</div>
			<div class="modal-body">
				<!--DEBUG_REPORT-->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

</body>
