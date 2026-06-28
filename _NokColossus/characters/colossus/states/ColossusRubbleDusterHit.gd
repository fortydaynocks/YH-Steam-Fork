extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _frame_1():
	host.do_asta_text(host.asta_emotes.RubbleDuster, 0.5, 2)

func _frame_54():
	host.end_invulnerability()

func _tick():
	._tick()
	
	if current_tick >= 1 and current_tick <= 41:
		var pos = host.get_pos()
		var vel = host.get_vel()
		
		host.opponent.set_pos(pos.x, pos.y)
		host.opponent.set_vel(vel.x, vel.y)

		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "Knockdown"
		host.opponent.sprite.frame = 0
		
		if current_tick <= 32 and current_tick % 4 == 1:
			host.play_sound("Landing")
			
			host.screen_bump(Vector2(0, 0), 2, 0.25)
			
			host.opponent.take_damage(12)
			host.spawn_particle_effect_relative(particle_scene, Vector2(0, 0))
