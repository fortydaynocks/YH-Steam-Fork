extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var initial_dist = 4
var speeds = [16, 12]
var speed = 16
var max_tracking = 3

func _enter():
	._enter()
	
	host.afterimage2(host.extra_color_2, 0.4)

func _exit():
	._exit()
	
	host.change_stance_to("Normal")

func _frame_3():
	var dir = data["Direction"].x * host.get_facing_int()
	
	if dir == 1:
		anim_name = "quietusF"
	else:
		anim_name = "quietusB"
	
	if dir == 1:
		if data.Short == false:
			host.apply_force_relative(str(speeds[0]), "0")
			
			host.move_directly_relative("50", "0")
			host.play_sound("heartbeat")
			host.play_sound("awaken")
			host.spawn_particle_effect_relative(timed_particle_scene, Vector2(0, -18))
			
		else:
			host.apply_force_relative(str(speeds[0] / 1.5), "0")
			
		host.change_stance_to("Torture")
	else:
		if data.Short == false:
			host.apply_force_relative(str(-speeds[1]), "0")
			
		else:
			host.apply_force_relative(str(-speeds[1] / 2), "0")
			
		host.change_stance_to("Misery")
		
func _frame_8():
	if host.combo_count > 0:
		self.enable_interrupt()
	
func _tick():
	._tick()
	
	if current_tick % 2 == 0:
		host.afterimage2(host.extra_color_2, 0.1)

	if host.is_grounded() == false:
		var diff = host.opponent.get_pos().y - host.get_pos().y
		host.move_directly_relative("0", str(clamp(diff, -max_tracking, max_tracking)))
