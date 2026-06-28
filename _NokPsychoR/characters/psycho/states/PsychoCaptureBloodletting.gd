extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var pause = 0

func _enter():
	._enter()
	
	pause = 0
	
	host.opponent.change_state("Grabbed")
	host.start_invulnerability()
	
	if host.previous_state():
		if not host.previous_state().state_name in [self.state_name]:
			host.play_sound("WoundSwing")
	
func _frame_0():
	if $"%Stuff".skin == "Aimorrago":
		$"%Stuff".do_text("...Give your blood.")
		
	else:
		host.play_sound("BloodlettingVoice")
	
func _frame_12():
	host.release_opponent()
	host.play_sound("Transfuse4")
	
func _frame_13():
	host.opponent.change_state("Grabbed")
	
func _frame_25():
	host.play_sound("BloodlettingSwing")
	
func _frame_28():
	host.release_opponent()

func _tick():
	._tick()
	
	if current_tick < 12:
		host.global_hitlag(1)
			
	if current_tick >= 13 and current_tick <= 21:
		if host.scars > 0:
			host.scars -= 1
			host.wounds += 1
			
			host.opponent.take_damage(2, 2)
			
			if current_tick % 4 == 0:
				host.play_sound("BloodlettingBleed")
				host.opponent.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoBloodwashSlash.tscn"), Vector2(0, -18))
			
			host.opponent.can_update_sprite = false
			host.opponent.sprite.animation = "WallSlam"
			host.opponent.update_facing()
			
			if current_tick == 21:
				current_tick -= 2
			
		else:
			if current_tick == 21:
				if pause < 10:
					pause += 1
					current_tick -= 2
	
	if current_tick in [25, 26, 27, 28]:
		host.global_hitlag(1)
