extends CharacterState

func _frame_4():
	host.has_hyper_armor = true

func _exit():
	host.has_hyper_armor = false

func _frame_2():
	var dir = xy_to_dir(data.x, data.y, "8")
	host.apply_force(dir.x, dir.y)
