extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _enter():
	._enter()
	
	host.opponent.z_index -= 1
	
func _exit():
	._exit()
	
	host.opponent.z_index += 1

func _frame_0():
	host.start_invulnerability()	
	host.apply_force_relative("6", "0")
	host.release_opponent()

func _frame_22():
	
	host.apply_force_relative("4", "0")
	
func _tick():
	._tick()
	
	if current_tick <= 14:
		host.opponent.rumble(2, 1)
	
	if current_tick < 23:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "Knockdown"
