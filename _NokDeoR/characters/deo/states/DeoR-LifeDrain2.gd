extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func _frame_0():
	host.opponent.change_state("Grabbed")
	host.start_invulnerability()
	host.play_sound("LifeDrainHeal")
	
func _frame_24():
	host.release_opponent()

func _tick():
	._tick()
	
	if current_tick in [3, 9, 13]:
		host.global_hitlag(4)
		host.play_sound("LifeDrainHit")
		host.opponent.rumble(1, 6)
	
		host.gain_super_meter(15)
		host.opponent.drain_super_meter(15)
		host.opponent.take_damage(5)
	
	if current_tick >= 17 and current_tick < 25:
		host.global_hitlag(2)
		
	if current_tick < 25:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "WallSlam"
		host.opponent.sprite.frame = 0
		host.opponent.sprite.z_index = -1
