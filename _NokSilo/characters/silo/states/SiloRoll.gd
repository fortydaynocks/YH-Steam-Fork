extends RollDodge

func _tick():
	._tick()
	
	host.afterimage(Color.red, 0.1)

	if current_tick % 2 == 0 and host.is_grounded() == true:
		host.spawn_particle_effect_relative(host.vfx_table.Flower, Vector2(0, 0))
