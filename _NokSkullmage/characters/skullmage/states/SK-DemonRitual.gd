extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

#	--
func _enter():
	._enter()
	
	host.grab_camera_focus()
	
func _exit():
	._exit()
	
	host.release_camera_focus()

#	--
func _frame_0():
	host.play_sound("DemonRitual")
	host.play_sound("DemonRitual2")
	
func _frame_1():
	host.link.Max += 1

func _tick():
	._tick()
	
	host.global_hitlag(1)
