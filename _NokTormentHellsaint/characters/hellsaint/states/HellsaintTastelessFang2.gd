extends ThrowState

#var _heal = 4
var _damage = 5
var loops = 0

func _enter():
	._enter()
	
	host.start_invulnerability()
	
	loops = 0
	
func _frame_0():
	host.reset_momentum()
	host.apply_force_relative("8", "0")
	
func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost4")

func _tick():
	._tick()
	
	if current_tick < 17:
		#if host.hp + _heal >= host.MAX_HEALTH:
			#host.hp = host.MAX_HEALTH
		#else:
			#host.hp += _heal
		
		if current_tick % 2 == 1:
			host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS-HitFang.tscn"), Vector2(0, -36))
			host.play_sound("tastelessfanghit")
			
			host.opponent.take_damage(_damage)
			host.visible_combo_count += 1
			host.gain_super_meter(2)
			
			host.opponent.rumble(1, 1)
			host.opponent.rumble(2, 4)
			
		if current_tick == 17:
			host.play_sound("tastelessfangcharge")
			
		if current_tick >= 17 and current_tick <= 27:
			host.global_hitlag(1)
			
	#	--
	if current_tick >= 15:
		if loops < 12:
			current_tick = 13
			loops += 1
