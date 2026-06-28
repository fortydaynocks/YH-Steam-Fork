extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

onready var proj = preload("res://_NokDeoR/characters/deo/projectiles/Knives.tscn")
var speed = 12

func _frame_6():
	var dir = xy_to_dir(data["Target"].x, data["Target"].y, str(speed))
	
	var obj = host.spawn_object(proj, 18, -18, true, {"dir": dir}, true)
	obj.set_grounded(false)
	obj.apply_force(dir.x, dir.y)
	
func _frame_8():
	var dir = xy_to_dir(data["Target 2"].x, data["Target 2"].y, str(speed))
	
	var obj = host.spawn_object(proj, 18, -18, true, {"dir": dir}, true)
	obj.set_grounded(false)
	obj.apply_force(dir.x, dir.y)
