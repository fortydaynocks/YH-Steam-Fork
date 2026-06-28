extends ActionUIData

var selected = null
var selection_cost = 0

#	--
func get_data():
	return {
		"Action": selected,
		"Cost": selection_cost
	}
	
#	--
func button_pressed(button):
	$"%NameLabel".modulate = Color(0, 1, 1)
	$"%NameLabel".text = button.properties.state
	$"%MeterLabel".text = str(button.properties.cost) + " cost"
	$"%StancesLabel".text = "["+ str(button.properties.stances) + "]"
	
	selected = button.properties.state
	selection_cost = button.properties.cost
	self.emit_signal("data_changed")
	
#	--
func on_button_selected():
	for child in $"%Container".get_children(): child.queue_free()
	$"%NameLabel".modulate = Color(0.5, 0.5, 0.5)
	$"%NameLabel".text = "Nothing chosen..."
	$"%MeterLabel".text = ""
	$"%StancesLabel".text = ""
	
	#	--
	var stand = load("res://_NokDeoR/characters/deo/projectiles/DeoRStand.tscn").instance()
	
	for action in stand.get_node("StateMachine").get_children():
		if action.get("action") == true:
			var button = $"%ActButton".duplicate()
			$"%Container".add_child(button)
			
			button.icon = action.action_icon
			button.properties["state"] = action.name
			button.properties["cost"] = action.action_cost
			button.properties["stances"] = action.action_stances
			button.connect("pressed", self, "button_pressed", [button])
			
			#	--
			if fighter.supers_available < action.action_cost:
				button.hint_tooltip += "Not enough super.\n"
				button.disabled = true
				
			if (not fighter.stance in action.action_stances) and (not "All" in action.action_stances):
				button.hint_tooltip += "Not in the right stance.\n"
				button.disabled = true
