{def $user = fetch( 'user', 'current_user' )}

<ul id="left-column-tabs" class="nav nav-tabs" role="tablist">
	<li role="presentation" class="active">
		<a href="#tab-bookmarks" aria-controls="profile" role="tab" data-toggle="tab">Bookmarks</a>
	</li>
	<li role="presentation">
		<a href="#tab-all" aria-controls="home" role="tab" data-toggle="tab">All</a>
	</li>
	<li role="presentation">
		<a href="#tab-search" aria-controls="messages" role="tab" data-toggle="tab">Search</a>
	</li>
</ul>

<div class="tab-content">
	<div role="tabpanel" class="tab-pane active" id="tab-bookmarks">
		<div class="tree">
			<ul>
				<li id="{$user.contentobject.main_node_id}" class="lazy folder">
					{$user.contentobject.name|wash()}
				</li>
			</ul>
		</div>
	</div>

	<div role="tabpanel" class="tab-pane" id="tab-all">
		<div class="tree">
			<ul>
				<li class="lazy folder" id="1">
					All
				</li>
			</ul>
		</div>
	</div>

	<div role="tabpanel" class="tab-pane" id="tab-search">
		<div class="tree">
			<ul>
				<li class="container" data-value="0" data-open="0">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search for...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button">Go!</button>
						</span>
					</div>
				</li>
			</ul>
		</div>
		<div class="tree">
			<ul>
				<li class="container" data-value="0" data-open="0">
					<span class="icon-folder-open"></span>
					Saved Searches
				</li>
			</ul>
		</div>
	</div>
</div>

{literal}
<script>
$(function()
{
	//drops debug output
	function cleanData( data )
	{
		return data.replace( /\<div id="debug"[\s\S]*div\>/i, '' );
	}

	glyph_opts = {
		map: {
			doc: "glyphicon glyphicon-file",
			docOpen: "glyphicon glyphicon-file",
			checkbox: "glyphicon glyphicon-unchecked",
			checkboxSelected: "glyphicon glyphicon-check",
			checkboxUnknown: "glyphicon glyphicon-share",
			dragHelper: "glyphicon glyphicon-play",
			dropMarker: "glyphicon glyphicon-arrow-right",
			error: "glyphicon glyphicon-warning-sign",
			expanderClosed: "glyphicon glyphicon-triangle-right",
			expanderLazy: "glyphicon glyphicon-triangle-right",  // glyphicon-expand
			expanderOpen: "glyphicon glyphicon-triangle-bottom",  // glyphicon-collapse-down
			folder: "glyphicon glyphicon-folder-close",
			folderOpen: "glyphicon glyphicon-folder-open",
			loading: "glyphicon glyphicon-refresh glyphicon-spin"
		}
	};

	$( '.tree' ).fancytree(
	{
		extensions: ['persist', 'glyph', 'dnd' ],
		glyph: glyph_opts,
		checkbox: true,
		persist:
		{
			expandLazy: true,
			// fireActivate: false,    // false: suppress `activate` event after active node was restored
			// overrideSource: false,  // true: cookie takes precedence over `source` data attributes.
			store: 'local' // 'cookie', 'local': use localStore, 'session': sessionStore
		},
		lazyLoad : function( event, data )
		{
			var request =
			{
				url: eZBaseUrl + '/mugo_bootstrap_admin/treemenu_list',
				data:
				{
					type: data.node.data.type || 'node_id',
					value: data.node.key
				},
				cache: false,
			};

			var cacheValue = localStorage.getItem( 'fancytree_' + data.node.key );
			if( cacheValue !== null )
			{
				//from cache
				data.result = JSON.parse( cacheValue );
			}
			else
			{
				data.result = request;
			}
		},
		postProcess: function(event, data)
		{
			var key = 'fancytree_' + data.node.key;
			localStorage.setItem( key, JSON.stringify( data.response ) );
		},
		collapse: function( event, data )
		{
			// explicitly remove caches
			var key = 'fancytree_' + data.node.key;
			localStorage.removeItem( key );

			data.node.resetLazy();
		},
		click: function( event, data )
		{
			if( event.toElement.className == 'fancytree-title' )
			{
				location.href = data.node.data.href;
			}

			if( event.toElement.className.match( /fancytree-(custom-|)icon/ ) )
			{
				// only init it once
				if( $( event.toElement ).attr( 'data-toggle' ) != 'contextmenu' )
				{
					$( event.toElement )
						.ezcontextmenu(
						{
							baseUrl: eZBaseUrl,
							data: data.node.data,
						})
						.ezcontextmenu( 'show' )
						.attr( 'data-toggle', 'contextmenu' );
				}
			}

			return true;
		},

		dnd:
		{
			autoExpandMS: 400,
			draggable: { // modify default jQuery draggable options
				zIndex: 1000,
				scroll: false,
				containment: "parent",
				revert: "invalid"
			},
			preventRecursiveMoves: true, // Prevent dropping nodes on own descendants
			preventVoidMoves: true, // Prevent dropping nodes 'before self', etc.

			dragStart: function(node, data) {
				// This function MUST be defined to enable dragging for the tree.
				// Return false to cancel dragging of node.
//    if( data.originalEvent.shiftKey ) ...
//    if( node.isFolder() ) { return false; }
				return true;
			},
			dragEnter: function(node, data) {
				/* data.otherNode may be null for non-fancytree droppables.
				 * Return false to disallow dropping on node. In this case
				 * dragOver and dragLeave are not called.
				 * Return 'over', 'before, or 'after' to force a hitMode.
				 * Return ['before', 'after'] to restrict available hitModes.
				 * Any other return value will calc the hitMode from the cursor position.
				 */
				// Prevent dropping a parent below another parent (only sort
				// nodes under the same parent):
//    if(node.parent !== data.otherNode.parent){
//      return false;
//    }
				// Don't allow dropping *over* a node (would create a child). Just
				// allow changing the order:
//    return ["before", "after"];
				// Accept everything:
				return true;
			},
			dragOver: function(node, data) {
			},
			dragLeave: function(node, data) {
			},
			dragStop: function(node, data) {
			},
			dragDrop: function(node, data)
			{
				// This function MUST be defined to enable dropping of items on the tree.
				// data.hitMode is 'before', 'after', or 'over'.
				// We could for example move the source to the new target:
				data.otherNode.moveTo( node, data.hitMode );
			}
		}
	});

	$( '#left-column-tabs' ).remembertab();
});
</script>
{/literal}