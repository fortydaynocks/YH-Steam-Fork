extends ActionUIData

onready var note = $Label

func _process(delta):
	if fighter.current_state():
		if fighter.current_state().name in ["duck", "duck2", "excover", "exduck"]:
			note.text = "Hits @ frame 3."
		elif fighter.current_state().name == "cover":
			note.text = "Hits @ frame 4."
		else:
			note.text = "How are you seeing this???"
