extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

var hopped = false
var can_hop = false

func _enter():
	._enter()
	hopped = false
	can_hop = false

func _frame_2():
	if host.initiative:
		host.start_projectile_invulnerability()
	host.reset_momentum()
	host.set_grounded(false)
	
	host.apply_force_relative(data["Distance"].x/5, (data["Direction"].y * 8) + 3)
	if data["Direction"].y > 0:
		can_hop = true
	else:
		can_hop = false

func _frame_6():
	host.end_projectile_invulnerability()
	
func _frame_10():
	
	if host.combo_count >= 1:
		enable_interrupt()
	
func _tick():
	._tick()
	
	if current_tick in [4, 11]:
		var dir = xy_to_dir(data["Distance"].x, "0", "1")
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), Vector2(float(dir.x), float(dir.y)))
		

	if hopped == false and can_hop == true:
		if host.is_grounded():
			host.apply_force_relative("0", fixed.mul(host.get_vel().y, "-1"))
			hopped = true

#	if current_tick >= 6 and host.is_grounded() == true and float(data.y) > 0:
#		host.reset_momentum()
#
#		var di_dir = xy_to_dir(host.current_di.x, host.current_di.y * 0.2, "16")
#		host.apply_force(di_dir.x, di_dir.y)
#
#		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), Vector2(float(di_dir.x), float(di_dir.y)).normalized())
		
#		return "Landing"
func _exit():
	._exit()
	host.mod_vel("0.25")
