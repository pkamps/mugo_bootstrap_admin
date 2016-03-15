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

<div id="waiting-modal" class="modal fade" data-backdrop="static" data-keyboard="false" tabindex="-1" role="dialog" aria-hidden="true" style="padding-top:15%; overflow-y:visible;">
	<div class="modal-dialog modal-m">
		<div class="modal-content">
			<div class="modal-header"><h3 style="margin:0;"></h3></div>
			<div class="modal-body">
				<div class="progress progress-striped active" style="margin-bottom:0;">
					<div class="progress-bar" style="width: 0%"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="contextmenu-content" class="template">
	<ul>
		{* <li><a data-action="view">View</a></li> *}
		<li><a href="/content/edit/[[contentobject_id]]">Edit</a></li>
		<li role="separator" class="divider"></li>
		<li><a href="#">Delete</a></li>
	</ul>
</div>
