extends ActionUIData


func _process(delta):
	if fighter.current_state().name in ["duck", "exduck", "cover"]:
		$Label.text = "Hits @ f5"
	else:
		$Label.text = ""
