extends ActionUIData

func get_data():
	return {
		"convert": $"%Convert".pressed,
		"compose": $"%Compose".pressed and $"%Compose".visible,
	}

func _process(delta):
	if fighter:
		$"%Compose".visible = fighter.insanity
