<ul>
{foreach $modules as $name => $identifier}
	<li class="container" data-value="{$identifier|wash()}" data-type="view">
		<span><i class="glyphicon glyphicon-oil"></i></span>
		<a href="#">{$name|wash()}</a>
	</li>
{/foreach}
</ul>
