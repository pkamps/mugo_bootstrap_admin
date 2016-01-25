<h1>{$node.name|wash()} <small>{$node.class_name|wash()}</small></h1>
<p>
	Last update <i>{$node.object.current.modified|l10n( 'datetime' )}</i>,
	<a href="#">{$node.object.current.creator.name|wash()}</a>
	<span class="pull-right">Languages: English</span>
</p>
