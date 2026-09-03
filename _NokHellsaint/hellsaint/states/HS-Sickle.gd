extends "res://_NokHellsaint/hellsaint/states/HS-State.gd"

onready var sickle = preload("res://_NokHellsaint/hellsaint/projectiles/Sickle.tscn")


func _frame_6():
	var dir = xy_to_dir(data.x, data.y, "24")
	var norm = Vector2(data.x, data.y).normalized()
	
	var proj = host.spawn_object(sickle, 20, -18, true, {"norm": norm}, true)
	proj.set_grounded(false)
	proj.set_facing(host.get_facing_int())
	proj.apply_force(dir.x, dir.y)
