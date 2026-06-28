extends ActionUIData


onready var note = $Label

func _process(delta):
	if fighter.current_state():
		if fighter.current_state().name == "duck" or fighter.current_state().name == "duck2":
			note.text = "Hits @ frame 8."
		elif fighter.current_state().name == "cover":
			note.text = "Hits @ frame 7."
		elif fighter.current_state().name in ["exduck", "excover"]:
			note.text = "Hits @ f8."
		else:
			note.text = "Hits @ frame 11."
