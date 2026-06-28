extends "res://_NokDeoR/characters/deo/projectiles/DeoRStandState.gd"

onready var proj = preload("res://_NokDeoR/characters/deo/projectiles/Knives.tscn")
var speed = 8

func _frame_8():
	var pos = host.get_pos()
	var fac = host.get_facing_int()
	var dir = {"x": "0", "y": "0"}
	
	var obj = host.get_owner().spawn_object(proj, pos.x + (18 * fac), pos.y - 28, true, {"dir": dir}, false)
	obj.set_grounded(false)
	obj.apply_force(str(speed * fac), str("-0.5"))
	
	var obj2 = host.get_owner().spawn_object(proj, pos.x + (18 * fac), pos.y - 8, true, {"dir": dir}, false)
	obj2.set_grounded(false)
	obj2.apply_force(str(speed * fac), str("0.5"))
