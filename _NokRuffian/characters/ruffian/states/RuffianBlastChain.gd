extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

export (bool) var force_init_effect = false

func _enter():
	._enter()
	host.play_sound("SuperSF3")

func _frame_0():
	host.cinematic(45, 5)

func _frame_2():
	if host.initiative:
		host.start_invulnerability()

func _frame_10():
	host.end_invulnerability()

func _tick():
	._tick()
	endless = true
	if current_tick in [17, 31] and host.is_grounded() == false:
		host.apply_grav()
		current_tick -= 2
	
	#self.apply_custom_grav = (current_tick >= 7 and current_tick < 37)
	if hitted == true:
		host.opponent.set_vel(host.get_vel().x, host.get_vel().y)
		
	#	--
	
	if current_tick == 2:
		host.apply_force_relative("8", "0")
	
	if current_tick == 7:
		host.reset_momentum()
		host.apply_force_relative("6", "-4")
		
	if current_tick == 23:
		host.reset_momentum()
		host.apply_force_relative("5", "-5")
		
	if current_tick == 37:
		host.reset_momentum()
		host.apply_force_relative("6", "-12")

	if current_tick > 43 and hitted == true and host.combo_count > 0:
		host.opponent.start_invulnerability()
		host.reset_pushback()
		host.opponent.reset_pushback()
	
	if current_tick in [20, 34]:
		host.play_sound("Landing")
		host.play_sound("SuperGain")
		
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
	
	if current_tick % 3 == 0:
		var fac = host.get_facing_int()
		var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), vel.normalized())

#func _on_hit_something(obj, hitbox):
#	._on_hit_something(obj, hitbox)


func on_got_blocked():
	.on_got_blocked()
	
	
	for h in get_active_hitboxes():
		if h.group == 4:
			hitted = false
			host.opponent.blockstun_ticks = 0
		else:
			hitted = true

#func _exit():
#	if hitted == true:
#		host.add_pushback("-25")
#		host.opponent.add_pushback("-25")
