extends ActionUIData


func _process(delta):
	if $Alt.pressed == true:
		$Alt.text = "EX Cover"
		fighter.duckicon.button_texture = preload("res://_NokRuffian/characters/ruffian/icons/rficonexcover.png")
		fighter.change_action_icon("exduck","res://_NokRuffian/characters/ruffian/icons/rficonexcover.png")

	else:
		$Alt.text = "EX Weave"
		fighter.duckicon.button_texture = preload("res://_NokRuffian/characters/ruffian/icons/rficonexducking.png")
		fighter.change_action_icon("exduck","res://_NokRuffian/characters/ruffian/icons/rficonexducking.png")

