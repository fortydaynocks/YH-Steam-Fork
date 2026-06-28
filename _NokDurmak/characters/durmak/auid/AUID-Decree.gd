extends ActionUIData

var chosen_entity = null
var chosen_action = null
var entity_list = []
var num = 0

#	--
func get_data():
	return {
		"Entity": chosen_entity,
		"Action": chosen_action
	}

#	--
func on_button_selected():
	.on_button_selected()
	
	chosen_entity = null
	chosen_action = null
	entity_list = []
	
	$"%Current".text = "..."
	$"%ActionName".text = "..."

	#	--
	if self.fighter:
		for entity in self.fighter.objs_map.values():
			if is_instance_valid(entity) and (not entity.disabled) and entity.get_owner() == self.fighter and entity.get("tag"):
				if "Walker" in entity.get("tag"):
					entity_list.append(entity.obj_name)
					
	num = 0
	set_selected()

#	--
func set_selected():
	if len(entity_list) <= 0: return
	if num > len(entity_list) - 1: num = 0
	if num < 0: num = len(entity_list) - 1
	
	#	--
	$"%Current".text = "..."
	$"%ActionName".text = "..."
	chosen_action = null
	
	for child in $"%GridContainer".get_children(): child.queue_free()
	var entity
	
	if self.fighter:
		if self.fighter.objs_map.get(entity_list[num]):
			chosen_entity = entity_list[num]
			entity = self.fighter.objs_map.get(entity_list[num])
			
	if entity:
		$"%Current".text = entity.get("tag") + " [" + str(entity.obj_name) + "]"
		
		for state in entity.state_machine.states_map.values():
			if state.get("action"):
				var new_button = $"%ActionButton".duplicate()
				new_button.icon = state.get("action_icon")
				new_button.editor_description = state.state_name
				new_button.visible = true
				new_button.connect("pressed", self, "action_button_pressed", [new_button])
				$"%GridContainer".add_child(new_button)
#	--
func action_button_pressed(button):
	self.emit_signal("data_changed")
	chosen_action = null
	
	for other_button in $"%GridContainer".get_children():
		if not button == other_button:
			other_button.set_pressed_no_signal(false)
			
	if button.pressed:
		chosen_action = button.editor_description
		
	$"%ActionName".text = chosen_action if chosen_action else "..."
	
#	--
func _on_Last_pressed():
	self.emit_signal("data_changed")
	
	num -= 1
	set_selected()

func _on_Next_pressed():
	self.emit_signal("data_changed")
	
	num += 1
	set_selected()
