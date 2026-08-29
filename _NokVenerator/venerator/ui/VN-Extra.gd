extends PlayerExtra

func get_extra():
	return {
		"flash": $"%Flash".pressed if !$"%Flash".disabled else false,
	}
	
#	-------------------------------------------------------------------------- |
func refresh_ui():
	var state = self.selected_move if self.selected_move else self.fighter.current_state()
	
	$"%Flash".disabled = true
	
	if !"NoFlash" in state.editor_description and self.fighter.supers_available >= 1:
		if !state.type in [4, 5]:
			$"%Flash".disabled = false

func reset():
	.reset()

	$"%Flash".pressed = false
	refresh_ui()

func update_selected_move(move_state):
	.update_selected_move(move_state)
	
	refresh_ui()

#	-------------------------------------------------------------------------- |
func _ready():
	$"%Flash".connect("pressed", self, "_update")
	
func _update():
	self.emit_signal("data_changed")
	
