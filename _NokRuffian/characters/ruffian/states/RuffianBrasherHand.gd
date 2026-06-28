extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

onready var hbox = $"HitboxBrasherHand"

func _enter():
	._enter()
	earliest_hitbox = 10

func _frame_1():
	var dir = xy_to_dir(data.x * host.get_facing_int(), data.y, "95")
#	host.mod_vel("0.50")
	if is_instance_valid(hbox):
		if fixed.round(dir.x) > 0:
			hbox.x = 100 + (fixed.round(dir.x))
		else:
			hbox.x = 100 + (fixed.round(dir.x)/3)
		hbox.y = (-host.hurtbox.height) + fixed.round(dir.y)

func _frame_9():
	var obj = host.spawn_object(preload("res://_NokRuffian/characters/ruffian/projectiles/RuffianBrashHandCosmetic.tscn"), hbox.x, hbox.y, true, null, true)
	obj.set_facing(1)
	obj.sprite.set_material(host.sprite.get_material())
