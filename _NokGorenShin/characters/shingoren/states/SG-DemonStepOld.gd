extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var mov_speed = 8
var adjust = 6
var do_advantage = false

#	--
func detect(obj):
	if obj == host.opponent:
		if host.combo_count > 0:
			host.opponent.hitlag_ticks = 12
			
		else:
			host.global_hitlag(8)
			
			host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit1.tscn"), Vector2(0, -18))
			host.play_sound("DemonStep3")
			host.opponent.change_state("ParryAuto")
			
			do_advantage = true
			
		if self._previous_state().get("do_advantage") == true:
			$"%Stuff".unlock_achievement("SG-DSTEP")

func _exit():
	._exit()

#	--
func _frame_0():
	do_advantage = false
	
	host.start_throw_invulnerability()
	host.start_projectile_invulnerability()
	
	self.interrupt_exceptions = ["Firewalk"]
	
	if data["Stance"] == true:
		self.interrupt_exceptions = ["NoFirewalk"]

func _frame_1():
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(-host.get_facing_int(), 0))

func _frame_5():
	host.play_sound("DemonStep")
	host.play_sound("DemonStep2")

func _frame_6():
	var pos = host.get_pos()
	var fac = host.get_facing_int()
	
	host.start_projectile_invulnerability()
	
	if host.is_grounded():
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke1.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	
	var dir = xy_to_dir(host.current_di.x, host.current_di.y, str(host.firewalk.Range))
	var swirl = host.spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/Fireswirl.tscn"), pos.x, pos.y, true, null, false)
	swirl.set_grounded(false)
	swirl.move_directly(str(dir.x), str(dir.y))
	
func _frame_14():
	host.start_throw_invulnerability()
	host.start_projectile_invulnerability()
	
func _tick():
	._tick()
	
	self.interruptible_on_opponent_turn = current_tick >= 6
	
	if do_advantage:
		host.opponent.blocked_hitbox_plus_frames = 3
	
	if current_tick < 6:
		host.global_hitlag(1)
	else:
		host._create_speed_after_image(Color("ff0044"), 0.15)
	
	if current_tick in [6, 7, 8, 9, 10, 11]:
		var dir = (float(data["Distance"].x) / 100) * adjust
		
		if host.reverse_state:
			if current_tick == 6:
				host.reset_momentum()
				host.apply_force_relative("6", "0")
			
			host.move_directly_relative(str(mov_speed / 2), "0")
			host.move_directly_relative(str(dir / 2), "0")
			
		else:
			if current_tick == 6:
				host.reset_momentum()
				host.apply_force_relative("8", "0")
			
			host.move_directly_relative(str(mov_speed), "0")
			host.move_directly_relative(str(dir), "0")
