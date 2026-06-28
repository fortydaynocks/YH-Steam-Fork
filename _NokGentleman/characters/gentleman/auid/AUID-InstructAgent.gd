extends ActionUIData

var chosen_agent = null
var chosen_action = null

#	--
func agent_button_toggled(toggle, button):
	emit_signal("data_changed")
	
	for other_button in $"%Agents".get_children():
		other_button.set_pressed_no_signal(false)
		
	if toggle == true:
		button.set_pressed_no_signal(true)
		chosen_agent = button.editor_description
		for other_button in $"%Actions".get_children(): other_button.queue_free()
		
		on_agent_chosen()
		
	else:
		button.set_pressed_no_signal(false)
		chosen_agent = null
		chosen_action = null
		
		on_agent_chosen()

func action_button_toggled(toggle, button):
	emit_signal("data_changed")
	
	for other_button in $"%Actions".get_children():
		other_button.set_pressed_no_signal(false)
		
	if toggle == true:
		button.set_pressed_no_signal(true)
		chosen_action = button.editor_description
		
	else:
		button.set_pressed_no_signal(false)
		chosen_action = null

func on_agent_chosen():
	$"%ChooseAction".visible = false
	$"%NoActions".visible = true
	
	if chosen_agent and self.fighter.obj_from_name(chosen_agent):
		var agent = self.fighter.obj_from_name(chosen_agent)
		
		$"%ChooseAction".visible = true
		
		if agent.current_state().get("action") == true and agent.current_state().get("actionable") == false:
			$"%NoActions".visible = true
			#$"%NoActions".text = "Busy..."
	
		else:
			for agent_state in agent.state_machine.states_map.values():
				if agent_state.get("action") == true and agent_state.get("choosable") == true:
					$"%NoActions".visible = false
					
					var action_button = $"%BaseButton".duplicate()
					action_button.text = agent_state.get("action_name")
					action_button.editor_description = agent_state.state_name
					action_button.visible = true
					action_button.connect("toggled", self, "action_button_toggled", [action_button])
					$"%Actions".add_child(action_button)
			
#	--
func on_button_selected():
	.on_button_selected()
	
	chosen_agent = null
	chosen_action = null
	
	for other_button in $"%Agents".get_children(): other_button.queue_free()
	for other_button in $"%Actions".get_children(): other_button.queue_free()
	$"%ChooseAction".visible = false
	$"%NoAgents".visible = true
	
	if self.fighter:
		for agent in self.fighter.objs_map.values():
			if is_instance_valid(agent) and agent.disabled != true and agent.get_owner() == self.fighter and agent.get("tag") in ["Agent"]:
				$"%NoAgents".visible = false
				
				var agent_button = $"%BaseButton".duplicate()
				agent_button.text = agent.get("agent_name")
				agent_button.editor_description = agent.obj_name
				agent_button.visible = true
				agent_button.connect("toggled", self, "agent_button_toggled", [agent_button])
				$"%Agents".add_child(agent_button)

func get_data():
	return {
		"Agent": chosen_agent,
		"Action": chosen_action if chosen_agent and $"%ChooseAction".visible == true else null
	}
