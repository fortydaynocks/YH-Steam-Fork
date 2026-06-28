extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_0():
	host.start_invulnerability()
	host.global_hitlag(8)

func _frame_6():
	host.play_sound("grief-swing")

func _frame_20():
	host.apply_force_relative("6", "0")
	
func _frame_24():
	host.release_opponent()
	
func _tick():
	._tick()
	
	if current_tick > 1:
		if current_tick < 25:
			host.opponent.can_update_sprite = false
			host.opponent.sprite.animation = "Getup"
		
		if current_tick <= 20:
			host.global_hitlag(1)
