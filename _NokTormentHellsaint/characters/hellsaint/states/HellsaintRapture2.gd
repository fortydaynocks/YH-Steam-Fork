extends ThrowState

func _enter():
	._enter()
	
	host.start_invulnerability()

func _exit():
	._exit()
	
	host.end_invulnerability()

#	--

			
func _frame_1():
	host.reset_momentum()
	host.apply_force_relative("2", "-8")
			
func _frame_24():
	host.play_sound("CMN_005")
	
func _frame_27():
	host.opponent.change_state("Wait")

#	--

func _tick():
	
	host.afterimage2(Color(1, 0, 0.27), 0.1)
	
	if current_tick >= 14 and current_tick < 27:
		host.apply_force_relative("-8", "8")
		host.afterimage()
		
	if current_tick >= 16 and current_tick < 27:
		if host.is_grounded() == false:
			if current_tick == 26:
				current_tick = 25
		else:
			current_tick = 27
			
	if current_tick == 28:
		host.spawn_particle_effect_relative(preload("res://characters/robo/GroundSlamEffect.tscn"), Vector2(0, 0))
		._release()
		self.released = true
		
		host.reset_momentum()
		host.apply_force_relative("-8", "0")
			
	._tick()
