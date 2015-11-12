<ol class="breadcrumb">
	{foreach $module_result.path as $entry}
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
