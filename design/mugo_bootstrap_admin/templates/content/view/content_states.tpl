{def $states = $object.allowed_assign_state_list}

{foreach $states as $data}
	<table class="content-states">
		<tr>
			<td rowspan="2">
				<strong>{$data.group.current_translation.name|wash()}</strong>
			</td>
			{foreach $data.states as $state}
				<td>{$state.current_translation.name|wash()}</td>
			{/foreach}
		</tr>
		<tr>
			{foreach $data.states as $state}
				<td><input {if $object.state_id_array|contains( $state.id )}checked="checked"{/if} type="radio" /></td>
			{/foreach}
		</tr>
	</table>
{/foreach}
