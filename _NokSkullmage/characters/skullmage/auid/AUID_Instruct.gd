extends ActionUIData

var chosen_entity = null
var chosen_action = null

#	--
func action_button_toggled(toggle, button):
	emit_signal("data_changed")
	
	for other_button in $"%ActionContainer".get_children():
		other_button.set_pressed_no_signal(false)
		
	if toggle == true:
		button.set_pressed_no_signal(true)
		chosen_action = button.entity
		
	else:
		button.set_pressed_no_signal(false)
		chosen_action = null


func entity_button_toggled(toggle, button):
	emit_signal("data_changed")
	$VBoxContainer2.visible = false
	for other_button in $"%ActionContainer".get_children(): other_button.queue_free()
	
	#	--
	for other_button in $"%EntityContainer".get_children():
		other_button.set_pressed_no_signal(false)
		
	if toggle == true:
		button.set_pressed_no_signal(true)
		chosen_entity = button.entity
		
		#	--
		$VBoxContainer2.visible = true
		
		if button.entity:
			for action in button.entity.state_machine.states_map.values():
				if action.get("action"):
					$"%NoAction".visible = false
					var new_button = $"%Button".duplicate()
					
					new_button.text = action.state_name.capitalize()
					new_button.entity = action
					new_button.visible = true
							
					new_button.connect("toggled", self, "action_button_toggled", [new_button])	
					$"%ActionContainer".add_child(new_button)
		
	else:
		button.set_pressed_no_signal(false)
		chosen_entity = null

#	--
func fighter_update():
	.fighter_update()

	chosen_entity = null
	chosen_action = null

func on_button_selected():
	.on_button_selected()
	
	for other_button in $"%EntityContainer".get_children(): other_button.queue_free()
	for other_button in $"%ActionContainer".get_children(): other_button.queue_free()
	
	$"%NoEntity".visible = true
	$"%NoAction".visible = true
	$VBoxContainer2.visible = false
	
	#	--
	if self.fighter:
		for entity in self.fighter.objs_map.values():
			if is_instance_valid(entity) and (not entity.disabled) and entity.creator == self.fighter and entity.get("skullmage_summon"):
				$"%NoEntity".visible = false
				var new_button = $"%Button".duplicate()
				
				new_button.text = str(entity.get("tag"))
				new_button.entity = entity
				new_button.visible = true
						
				new_button.connect("toggled", self, "entity_button_toggled", [new_button])	
				$"%EntityContainer".add_child(new_button)
	
	for other_button in $"%ActionContainer".get_children():
		other_button.queue_free()
	
	if self.fighter:
		if self.fighter.necro_target and self.fighter.obj_from_name(self.fighter.necro_target):
			var necro_target_obj = self.fighter.obj_from_name(self.fighter.necro_target)
			
			for obj_state in necro_target_obj.state_machine.states_map.values():
				if obj_state.get("instructable") == true:
					$"%NoSummon".visible = false
					$"%ScrollContainer".rect_min_size.y = 38
					
					var new_button = $"%ActionButton".duplicate()
					
					new_button.text = obj_state.get("action_name")
					new_button.visible = true
					new_button.editor_description = obj_state.state_name
					new_button.connect("toggled", self, "target_button_toggled", [new_button])
					
					$"%ActionContainer".add_child(new_button)

func get_data():
	var parse_entity = null
	var parse_action = null
	
	if chosen_entity: parse_entity = chosen_entity.obj_name
	if chosen_action: parse_action = chosen_action.state_name
	
	return {
		"Entity": parse_entity,
		"Action": parse_action,
	}

