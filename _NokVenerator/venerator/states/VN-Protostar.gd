extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")
var dist = 100
var offset = 50
var force = 6

func _frame_6():
	var dir = xy_to_dir(data.x * host.get_facing_int(), data.y, str(dist))
	var force_dir = xy_to_dir(host.current_di.x, host.current_di.y, str(force))
	#var used_offset = offset
	
	var proj = host.spawn_object(star, int(dir.x) + offset, int(dir.y) - 18, true, null, true)
	proj.set_grounded(false)
	proj.apply_force(str(force_dir.x), str(force_dir.y))
