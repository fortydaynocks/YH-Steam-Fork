extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")
var dist = 100
var offset = 50
var force = Vector2(6, 0)

var spawn_count = 3

func _frame_6():
	var dir = xy_to_dir(data.x * host.get_facing_int(), data.y, str(dist))
	
	for i in range(0, spawn_count):
		var factor = deg2rad((360 / spawn_count) * i)
		var force_dir = force.rotated(factor)
		
		var proj = host.spawn_object(star, int(dir.x) + offset, int(dir.y) - 18, true, null, true)
		proj.set_grounded(false)
		proj.apply_force(str(force_dir.x), str(force_dir.y))
	#proj.apply_force(str(force_dir.x), str(force_dir.y))
