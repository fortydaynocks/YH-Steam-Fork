extends PlayerExtra

var disallow_pilot = false

#	--
func check_pilot_usability(move_state):
	$"%Pilot".visible = self.fighter.necro_target != null
	$"%Pilot".modulate = Color("9c85cc")
	disallow_pilot = false
	
	if not move_state:
		$"%Pilot".visible = false
		disallow_pilot = true
		return

	if move_state.type in [4, 5] and (not "ForcePilot" in move_state.editor_description):
		disallow_pilot = true
		$"%Pilot".modulate = Color("8f8f8f")
			
	if "NoPilot" in move_state.editor_description:
		disallow_pilot = true
		$"%Pilot".modulate = Color("8f8f8f")

func reset():
	.reset()
	
	$"%Pilot".reset()
	
	if self.fighter:
		check_pilot_usability(self.fighter.current_state())
		

func update_selected_move(move_state):
	.update_selected_move(move_state)

	if move_state != null:
		check_pilot_usability(move_state)

#	--
func get_extra():
	return {
		"Pilot": $"%Pilot".get_data() if $"%Pilot".visible and disallow_pilot == false else null
	}
	
#	--
func _on_Pilot_data_changed():
	emit_signal("data_changed")
