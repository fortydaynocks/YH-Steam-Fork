extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

onready var summon = preload("res://_NokSkullmage/characters/skullmage/projectiles/summons/skeleton/Skeleton.tscn")
var dist = 150
var initial_dist = 100

func _frame_6():
	var dir = (float(data.x) / 100) * dist
	
	var obj = host.spawn_object(summon, dir + initial_dist, 0, true, null, true)
	
	obj.set_grounded(false)
	obj.set_facing(host.get_facing_int())
	obj.sprite.material = host.sprite.material
