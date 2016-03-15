{*
	entries:
	css_classes: string
*}

{if is_unset( $entries )}
	{def $entries = array()}
{/if}
{if is_unset( $css_classes )}
	{def $css_classes = ''}
{/if}

<table class="table nodes-table {$css_classes}">
	<thead>
		<tr>
			<td style="width: 20px;"></td>
			<td style="width: 40px;"></td>
			<td>Name</td>
			<td>Published</td>
			<td>Type</td>
		</tr>
	</thead>
	<tbody>
		<tr data-contentobject_id="[[contentObjectId]]" class="template">
			<td><input type="checkbox" /></td>
			<td>
				<div class="btn-group">
					<button class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" type="button">
						[[contentObjectId]]
					</button>
				</div>
			</td>
			<td>
				<a href=[[icon]]>[[name]]</a>
			</td>
			<td>[[published]]</td>
			<td>[[className]]</td>
		</tr>
		{foreach $entries as $entry}
			<tr data-node_id="{$entry.node_id}" data-contentobject_id="{$entry.contentobject_id}">
				<td><input type="checkbox" /></td>
				<td>
					<div class="btn-group">
						<button class="btn btn-default btn-sm" data-toggle="contextmenu" aria-haspopup="true" aria-expanded="false" type="button">
							<span class="icon-default icon-{$entry.class_identifier}"></span>
						</button>
						{*
						<ul class="dropdown-menu">
							<li><a href={concat( '/content/edit/', $entry.contentobject_id )|ezurl()}>Edit</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#">Delete</a></li>
						</ul>
						*}
					</div>
				</td>
				<td>
					<a href={$entry.url_alias|ezurl()}>{$entry.name|wash()}</a>
				</td>
				<td>{$entry.object.published|l10n( 'shortdatetime' )}</td>
				<td>{$entry.class_name}</td>
			</tr>
		{/foreach}
	</tbody>
	{if $entries|count()|not()}
		<tfoot>
			<tr>
				<td colspan="4" class="text-center">
					No entries
				</td>
			</tr>
		</tfoot>
	{/if}
</table>
