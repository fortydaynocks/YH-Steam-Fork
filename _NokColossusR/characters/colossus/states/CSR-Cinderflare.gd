extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

onready var cinderflare = preload("res://_NokColossusR/characters/colossus/projectiles/Cinderflare.tscn")

var initial_speed = 6
var force = 5

func _frame_7():
	var dir = xy_to_dir(data.x, data.y, str(force))
	
	var proj = host.spawn_object(cinderflare, 18, -22, true, null, true)
	proj.set_grounded(false)
	
	proj.apply_force(str(initial_speed * host.get_facing_int()), "0")
	proj.apply_force(dir.x, dir.y)
