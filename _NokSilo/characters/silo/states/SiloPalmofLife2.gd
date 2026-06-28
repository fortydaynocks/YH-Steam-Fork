extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func _frame_22():
	host.update_facing()

func _frame_23():
	host.reset_momentum()
	
	host.set_pos(host.opponent.get_pos().x, host.opponent.get_pos().y)
	host.move_directly_relative("-24", "0")
	
	host.apply_force_relative("-3", "-3")
	

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		var fac = host.get_facing_int()
		
		if "1" in hitbox.misc_data:
			host.opponent.reset_momentum()
			host.opponent.set_vel(str(-15 * fac), "0")
			
			host.spawn_particle_effect_relative(host.vfx_table.PortalSpikeFX, Vector2(0, -18))
		
		if "2" in hitbox.misc_data:
			host.opponent.reset_momentum()
			host.opponent.set_vel("0", "-15")
			
			host.spawn_particle_effect_relative(host.vfx_table.PortalSpikeFX, Vector2(0, -18))
		
		if "3" in hitbox.misc_data:
			host.opponent.reset_momentum()
			host.opponent.set_vel(str(15 * fac), "15")
			
			host.spawn_particle_effect_relative(host.vfx_table.PortalSpikeFX, Vector2(0, -18))
			
		if "4" in hitbox.misc_data:
			host.opponent.reset_momentum()
			host.opponent.set_vel("0", "-15")
			
			host.spawn_particle_effect_relative(host.vfx_table.PortalSpikeFX, Vector2(0, -18))
			
		if "5" in hitbox.misc_data:
			host.opponent.reset_momentum()
			host.opponent.set_vel(str(-15 * fac), "0")
			
			host.spawn_particle_effect_relative(host.vfx_table.PortalSpikeFX, Vector2(0, -18))
			
		
		#	--
		if "placemark" in hitbox.misc_data:
			host.apply_torture(obj)
			host.afterimage(Color.red, 1)
			
			host.stress += 0.12
			
func _tick():
	._tick()
	
	if current_tick >= 3 and current_tick <= 22:
		host.set_pos(host.opponent.get_pos().x, host.opponent.get_pos().y)
		host.set_vel(host.opponent.get_vel().x, host.opponent.get_vel().y)
