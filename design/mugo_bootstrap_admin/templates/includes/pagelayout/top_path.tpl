{* TODO: handle module/views - normalize media vs content section *}

{def $elements = $module_result.path}
{if $module_result.node_id}
	{set $elements = $elements|extract( 0, $elements|count()|dec() )}
{/if}

<div class="btn-group pull-right" role="group">
	<button type="button" class="btn btn-default">
		<span class="glyphicon glyphicon-bookmark" aria-hidden="true"></span>
	</button>
	<button data-href={'/user/logout'|ezurl()} type="button" class="btn btn-default">
		<span class="glyphicon glyphicon-off" aria-hidden="true"></span>
	</button>
</div>

<ol class="breadcrumb">
	<li></li>
	{foreach $elements as $entry}
		<li>
			{if $entry.url}
				<a href={$entry.url_alias|ezurl()}>
					{$entry.text|wash()}
				</a>
			{else}
				{$entry.text|wash()}
			{/if}
		</li>
	{/foreach}
</ol>
