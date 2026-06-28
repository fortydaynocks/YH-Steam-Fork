extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

onready var swirl = preload("res://_NokGorenShin/characters/shingoren/projectiles/Swirl.tscn")
export (bool) var is_fireswirl = false

var force = 10

func _frame_4():
	var dir = xy_to_dir(data.x, data.y * 0.75, str(force))
	var obj = host.spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/Swirl.tscn"), 18, -18, true, null, true)
	
	obj.set_grounded(false)
	obj.set_facing(host.get_facing_int())
	obj.apply_force_relative("14", "0")
	obj.apply_force(dir.x, dir.y)
	
	obj.is_fireswirl = is_fireswirl
	
