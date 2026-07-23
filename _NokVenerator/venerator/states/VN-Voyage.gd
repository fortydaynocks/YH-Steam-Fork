extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _frame_1():
	var dir = Vector2(data.x, data.y).normalized()
	
	host.voyage.turns_left = 1
	host.voyage.dir = dir

	if host.is_ghost:
		var pos = host.get_pos()
		var offset = host.voyage.strength * 50
		
		host.spawn_particle_effect(
			preload("res://fx/FlawedParryEffect.tscn"),
			Vector2(pos.x + (dir.x * offset), (pos.y + (dir.y * offset)) - 18)
		)
