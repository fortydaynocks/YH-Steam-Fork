extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var chase_speed = 3
var fast_chase_speed = 9
var stab_distance = 80
var y_chase = 4

var normal_plus = 2
var stronger_plus = 4

onready var hbox = $"%HitboxAPF"

func _frame_1():
	if host.is_grounded() == true:
		host.apply_force_relative("2", "0")
	
func _frame_14():
	host.play_sound("ApproachSpeedup")
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Super.tscn"), Vector2(0, -18))
	
func _frame_19():
	host.reset_momentum()
	host.apply_force_relative("6", "0")
	
	host.play_sound("ApproachStab")
		
func _tick():
	._tick()
	
	#if is_instance_valid(hbox):
		#if current_tick >= 14:
			#hbox.plus_frames = stronger_plus
		#else:
			#hbox.plus_frames = normal_plus
	
	#	--
	if current_tick >= 7 and current_tick <= 13:
		host.apply_force_relative(str(chase_speed), "0")
		host.global_hitlag(1)
		
	if current_tick >= 14 and current_tick < 19:
		host.apply_force_relative(str(fast_chase_speed), "0")
	
	if current_tick >= 7 and current_tick < 19:
		if host.is_grounded() == true:
			host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(0, -9), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Debris.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))

		host.afterimage(Color(1, 1, 1, 0.5), 0.1)
		
	if current_tick >= 20:
		host.global_hitlag(1)
		
	#	--
	if current_tick > 8 and current_tick < 18:
		if abs(host.opponent.get_pos().x - host.get_pos().x) <= stab_distance or host.reverse_state == true:
			current_tick = 18
			
		if host.is_grounded() == false:
			var mov = clamp(host.opponent.get_pos().y - host.get_pos().y, -y_chase, y_chase)
			host.move_directly_relative("0", str(mov))
	
	#if current_tick in [9, 10, 11, 12, 13, 14, 15, 16]:
		#host.move_directly_relative("12", "0")
		
		#if host.is_grounded() == true:
			#host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(0, -9), Vector2(host.get_facing_int(), 0))

		#else:
			#var adj = clamp(host.opponent.get_pos().y - host.get_pos().y, -4, 4)
			#host.move_directly_relative("0", str(adj))
