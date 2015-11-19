{def $elements = $module_result.path|extract( 0, $module_result.path|count()|dec() )}
<ol class="breadcrumb">
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
