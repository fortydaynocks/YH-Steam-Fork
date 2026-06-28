extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var has_hit_projectile = false

func _enter():
	._enter()
	
	host.start_projectile_invulnerability()
	self.interruptible_on_opponent_turn = false
	
	self.anim_name = "decline" + str(host.randi_range(1, 3))
	has_hit_projectile = false
	
func _frame_6():
	if has_hit_projectile == false:
		host.end_projectile_invulnerability()
		
func detect(obj):
	.detect(obj)
	
	if current_tick <= 6:
		if is_instance_valid(obj):
			if (not obj is Fighter):
				has_hit_projectile = true
				self.interruptible_on_opponent_turn = true
					
				obj.reset_momentum()
				obj.set_facing(host.get_facing_int())
				obj.set_grounded(false)
				obj.apply_force(str(12 * host.get_facing_int()), "-4")
				
				host.play_sound("DeclineHit1")
				host.play_sound("Ex2")
				
				host.screen_bump(Vector2(0, 0), 2, 0.25)
				host.global_hitlag(6)
				
			else:
			
				host.apply_force_relative("-4", "0")
				host.opponent.apply_force(str(8 * host.get_facing_int()), "0")
				
				host.play_sound("DeclineHit1")
				host.play_sound("Ex2")
				
				host.screen_bump(Vector2(0, 0), 2, 0.25)
				host.global_hitlag(6)
