extends PlayerExtra

func update_stand_actions(clear = false):
	if clear == true: $"%StandActionList".clear()
	
	#	--
	if is_instance_valid(fighter) and fighter.stand:
		var chosen_state = self.selected_move if self.selected_move else fighter.state_machine.states_map[fighter.current_state().fallback_state]
		$"%StandActionContainer".visible = true
		
		#	--
		var stand_obj = fighter.get_stand(); if stand_obj:
			if stand_obj.current_state().get("interruptible") == true:
				$"%StandBusy".visible = false
				
				#	--
				
				for stand_state in stand_obj.state_machine.states_map.keys():
					var stand_state_obj = stand_obj.state_machine.states_map[stand_state]
					
					#	--
					var can_i_add_this_state = true
					if chosen_state.get("stand_action_state") == true:
						can_i_add_this_state = (stand_state_obj.get("selectable") == true)
					else:
						can_i_add_this_state = (stand_state_obj.get("selectable") == true and stand_state_obj.get("requires_action_state") == false)
					
					#	--
					if can_i_add_this_state == true:
						var does_this_state_already_exist = false	
						
						for existing_item_index in range(0, $"%StandActionList".get_item_count()):
							if $"%StandActionList".get_item_text(existing_item_index) == stand_state:
								does_this_state_already_exist = true
						
						if does_this_state_already_exist == false:
							$"%StandActionList".add_item(stand_state, stand_state_obj.get("state_icon"))
						
					else:
						for existing_item_index in range(0, $"%StandActionList".get_item_count()):
							if $"%StandActionList".get_item_text(existing_item_index) == stand_state:
								$"%StandActionList".remove_item(existing_item_index)
				
			else:
				$"%StandBusy".visible = true
				$"%StandBusy".text = "Stand is busy, performing " + stand_obj.current_state().state_name
		
	else:
		$"%StandActionContainer".visible = false
	
	"""
	print($"%StandActionList".get_selected_items())
	$"%StandActionContainer".visible = false
	var last_selected = $"%StandActionList".get_selected_items()[0] if $"%StandActionList".get_item_count() > 0 else null
	$"%StandActionList".clear()
	
	#	--
	if is_instance_valid(fighter) and fighter.stand:
		var stand_obj = fighter.objs_map[fighter.stand]; if is_instance_valid(stand_obj):
			$"%StandActionContainer".visible = true
			
			if stand_obj.current_state().get("interruptible") == true:
				$"%StandBusy".visible = false
				
				for stand_state in stand_obj.state_machine.states_map.keys():
					var stand_state_obj = stand_obj.state_machine.states_map[stand_state]
					
					#	--
					var can_i_add_this_state = true
					if move_state.get("stand_action_state") == true:
						can_i_add_this_state = (stand_state_obj.get("selectable") == true)
					else:
						can_i_add_this_state = (stand_state_obj.get("selectable") == true and stand_state_obj.get("requires_action_state") == false)
					
					if can_i_add_this_state == true:
						$"%StandActionList".add_item(stand_state, stand_state_obj.get("state_icon"))
					
					#$"%StandActionList".select(last_selected or 0)
					$"%StandActionList".select(2)
			else:
				$"%StandBusy".visible = true
				$"%StandBusy".text = "Stand is busy, performing " + stand_obj.current_state().state_name
				
				return
	"""

func show_options():
	.show_options()
	
	update_stand_actions(true)
			
func update_selected_move(move_state):
	.update_selected_move(move_state)

	$"%Pilot".visible = false

	if move_state:
		$"%Pilot".visible = ("StandAction" in move_state.editor_description) and not ("NoStandPilot" in move_state.editor_description)

	update_stand_actions(false)

# ---------------------------------------------------------------------------- |
func _on_StandAction_item_selected(index):
	emit_signal("data_changed")

func _on_StandActionList_item_selected(index):
	emit_signal("data_changed")
	
func _on_Pilot_data_changed():
	emit_signal("data_changed")

# ---------------------------------------------------------------------------- |
func get_extra():
	var selection = $"%StandActionList".get_selected_items()
	if len(selection) > 0: selection = selection[0]; else: selection = 0
	
	return {
		"StandAction": $"%StandActionList".get_item_text(selection),
		"StandActionData": null,
		"StandPilot": $"%Pilot".get_data() if $"%Pilot".visible == true else null,
	}
