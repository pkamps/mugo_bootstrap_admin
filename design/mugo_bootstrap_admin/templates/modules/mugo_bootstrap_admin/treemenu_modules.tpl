<ul>
{foreach $modules as $module}
	<li class="container">
		<span><i class="glyphicon glyphicon-oil"></i></span> {$module.name|wash()}
		{if $module.views|count()}
			<ul>
				{foreach $module.views as $view}
					<li style="display: none;">
						<span><i class="glyphicon glyphicon-oil"></i></span> <a href={$view.url|ezulr()}>{$view.name|wash()}</a>
					</li>
				{/foreach}
			</ul>
		{/if}
	</li>
{/foreach}
</ul>