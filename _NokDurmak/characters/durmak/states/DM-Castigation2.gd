extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _exit():
	host.release_camera_focus()
	
func _frame_2():
	host.release_opponent()

func _frame_30():
	host.apply_force_relative("8", "0")
	
func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if current_tick <= 24:
		host.move_directly_relative("8", "0")
		host.apply_force_relative("1", "0")
