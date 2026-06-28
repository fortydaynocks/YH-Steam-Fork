extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var speed = 60

func is_usable():
	var moves_used = host.combo_moves_used.keys()
	
	return .is_usable() and (not self.state_name in moves_used)

func _exit():
	host.release_camera_focus()

func _frame_0():
	host.play_sound("scary1")
	host.spawn_particle_effect_relative(preload("res://_NokDurmak/characters/durmak/effects/DM-EyeFlash.tscn"), Vector2(0, 0))
	host.grab_camera_focus()
	
func _frame_10():
	host.release_camera_focus()
	host.update_facing()

func _frame_22():
	host.apply_force_relative("4", "0")
	
func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if current_tick < 10:
		host.apply_force_relative("1", "0")
		host.global_hitlag(2)
	
	if current_tick >= 10 and current_tick <= 22:
		if (pos.x < opos.x and host.get_facing_int() == 1) or (pos.x > opos.x and host.get_facing_int() == -1):
			host.move_directly_relative(str(speed), "0")
			
		else:
			host.move_directly_relative("4", "0")
			
		#	--
		if current_tick % 3 == 0:
			host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(), Vector2(host.get_facing_int(), 0))
			host.play_sound("slide")
		
		
		
