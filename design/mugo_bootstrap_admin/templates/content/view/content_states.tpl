{def $states = $object.allowed_assign_state_list}

{foreach $states as $data}
	<table style="width: 100%;">
		<tr>
			<td></td>
			{foreach $data.states as $state}
				<td>{$state.current_translation.name|wash()}</td>
			{/foreach}
		</tr>
		<tr>
			<td>
				<strong>{$data.group.current_translation.name|wash()}</strong>
			</td>
			{foreach $data.states as $state}
				<td><input type="radio" /></td>
			{/foreach}
		</tr>
	</table>
{/foreach}
