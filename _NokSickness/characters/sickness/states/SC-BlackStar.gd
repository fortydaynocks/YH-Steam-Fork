extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

onready var black_star = preload("res://_NokSickness/characters/sickness/projectiles/BlackStar.tscn")

func _frame_7():
	var proj = host.spawn_object(black_star, 20, -20, true, null, true)
	proj.set_grounded(false)
	proj.apply_force_relative("8", "0")
