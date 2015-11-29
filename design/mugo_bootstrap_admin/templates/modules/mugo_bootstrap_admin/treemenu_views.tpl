<ul>
{foreach $views as $name => $uri}
	<li>
		<span><i class="glyphicon glyphicon-flash"></i></span>
		<a href={$uri|ezurl()}>{$name|wash()}</a>
	</li>
{/foreach}
</ul>
