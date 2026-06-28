extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

#	--

func _enter():
	._enter()
	
	host.start_invulnerability()
	host.opponent.grab_camera_focus()
	
func _exit():
	._exit()
	#host.opponent.release_camera_focus()
	
func _tick():
	._tick()
	
	if current_tick > 1 and current_tick < 8:
		host.global_hitlag(1)
		
	if current_tick > 32 and current_tick < 38:
		host.global_hitlag(1)
		
	#	--
		
	if current_tick == 98:
		host.opponent.release_camera_focus()
