extends "res://_NokGentleman/characters/gentleman/projectiles/AgentState.gd"

onready var hbox = $"%HitboxSureShot"
onready var hbox2 = $"%HitboxSureShot2"

func _frame_0():
	if not data.target:
		host.change_state("Default")

func _frame_11():
	if data.target:
		var mark = host.objs_map.get(data.target)
		if is_instance_valid(hbox) and is_instance_valid(hbox2) and is_instance_valid(mark) and mark.disabled != true:
			var pos = host.get_pos()
			var mark_pos = mark.get_pos()
			
			hbox.to_x = (mark_pos.x - (pos.x + hbox.x)) * host.get_facing_int()
			hbox.to_y = mark_pos.y - (pos.y + hbox.y)
			
			hbox2.x = (mark_pos.x - (pos.x)) * host.get_facing_int()
			hbox2.y = mark_pos.y - (pos.y)
			
			var point_vector = Vector2(mark_pos.x - (pos.x + 23), mark_pos.y - (pos.y - 27))
			
			host.spawn_particle_effect_relative(preload("res://_NokGentleman/characters/gentleman/effects/GM_Gunshot.tscn"), Vector2(23, -27), point_vector)
			mark.spawn_particle_effect_relative(preload("res://_NokGentleman/characters/gentleman/effects/GM_HitGun1.tscn"), Vector2(0, 0))
			mark.disable()
