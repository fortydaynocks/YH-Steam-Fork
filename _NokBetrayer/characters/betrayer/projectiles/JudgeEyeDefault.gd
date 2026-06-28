extends ObjectState

export (int) var lifetime = 300

func _frame_0():
	if host.eye_type == "Justice":
		self.anim_name = "proj-judgeeye-justice"
		host.sprite.scale = Vector2(1.5, 1.5)
		
		if host.get_owner().abs_asc <= 0:
			lifetime = 600
			host.tag = "EyeOfJustice"

func _tick():
	._tick()
	
	if current_tick >= lifetime:
		host.disable()
		return
