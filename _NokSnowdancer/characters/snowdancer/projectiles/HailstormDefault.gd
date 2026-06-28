extends ObjectState

var lifespan = 70

var width = 75
var pattern = [-width, (width * 0.75), -(width * 0.5), (width * 0.25), 0, -(width * 0.25), (width * 0.5), -(width * 0.75), width]

func _tick():
	._tick()
	
	if current_tick % 5 == 0 and current_tick < lifespan:
		var pos = host.get_pos()
		
		var icicle = host.creator.spawn_object(host.creator.objs_table.Icicle, pos.x + (pattern[host.pattern_stage[0]] * host.get_facing_int()), pos.y, false, null, false)
		icicle.set_grounded(false)
		icicle.apply_force("0", "12")
		
		host.play_sound("Spawn")
		host.creator.spawn_particle_effect(particle_scene, Vector2(icicle.get_pos().x, icicle.get_pos().y))
	
		host.pattern_stage[0] += 1
		if host.pattern_stage[0] > host.pattern_stage[1]:
			host.pattern_stage[0] = 1
	
	if current_tick >= lifespan:
		host.disable()
