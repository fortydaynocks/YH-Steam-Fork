extends ActionUIData

var chosen_summon = null

#	--
func summon_button_toggled(toggle, button):
	emit_signal("data_changed")
	
	for other_button in $"%Container".get_children():
		other_button.set_pressed_no_signal(false)
		
	if toggle == true:
		button.set_pressed_no_signal(true)
		chosen_summon = button.entity
		
	else:
		button.set_pressed_no_signal(false)
		chosen_summon = null

#	--
func on_button_selected():
	.on_button_selected()
	
	chosen_summon = null
	
	for other_button in $"%Container".get_children():
		other_button.queue_free()
	
	#for other_button in $"%SummonsContainer".get_children():
		#other_button.queue_free()
	
	#	--
	if self.fighter:
		for summon in self.state.get("entity_list"):
			if summon:
				var entity = summon.instance()
				var new_button = $"%SummonButton".duplicate()
				
				new_button.text = str(entity.get("tag"))		
				new_button.hint_tooltip = "HP: " + str(entity.get("max_hp")) + "\nWeight: " + str(entity.get("summon_weight")) + "\n" + self.state.get("summon_description")
				new_button.entity = summon
				new_button.visible = true
						
				new_button.connect("toggled", self, "summon_button_toggled", [new_button])
				
				if self.fighter.link.Value >= self.fighter.link.Max:
					new_button.disabled = true
					new_button.hint_tooltip = "Insufficient Link."		
								
				$"%Container".add_child(new_button)
				entity.queue_free()
			
	#if self.fighter:
		#for summon_state in fighter.state_machine.states_map.values():
			#if summon_state.get("summon_state") == true and summon_state.get("summon_entity") and summon_state.get("summon_entity").can_instance():
				#if self.fighter.rank.Value >= summon_state.get("required_rank"):
						
					#var entity = summon_state.get("summon_entity").instance()
					#var new_button = $"%SummonButton".duplicate()
					
					#new_button.get_node("Rank").text = str(summon_state.get("required_rank"))
					#new_button.get_node("Button").text = str(entity.get("tag"))		
					#new_button.get_node("Button").hint_tooltip = "HP: " + str(entity.get("max_hp")) + "\nWeight: " + str(entity.get("summon_weight")) + "\n" + summon_state.get("summon_description")
					
					#new_button.editor_description = summon_state.get("state_name")
					#new_button.visible = true
					
					#new_button.get_node("Button").connect("toggled", self, "summon_button_toggled", [new_button])
					
					#	--
					#if summon_state.get("ignore_link") != true:
						#if self.fighter.link.Value >= self.fighter.link.Max:
							#new_button.get_node("Button").disabled = true
							#new_button.get_node("Button").hint_tooltip = "Insufficient Link."
							
						#elif self.fighter.link.Value + entity.get("summon_weight") > self.fighter.link.Max:
							#new_button.get_node("Button").add_color_override("font_color", Color("#ff4b4b"))
							#new_button.get_node("Button").hint_tooltip += "\n\n!! Risk of being Encumbered !!"
							
							
					#	--
					#$"%SummonsContainer".add_child(new_button)
					#entity.queue_free()

#	--
func get_data():
	return {
		"Summon": chosen_summon,
		"Placement": $"%Placement".get_data(),
	}
