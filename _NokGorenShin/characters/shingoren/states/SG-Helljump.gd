extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var jump_force = 14
var stored_plus_frames = 0
var retreat = [0, 4]
var helljumps_used = 0

func _enter():
	._enter()
	
	stored_plus_frames = host.opponent.blocked_hitbox_plus_frames
	
	host._create_speed_after_image(Color("cc2f7b"), 0.2)
	
func _frame_0():
	if data["Retreat"] == true:
		retreat[0] = retreat[1]
		
		host.play_sound("HelljumpDash")
		if host.is_grounded() == true:
			host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(-host.get_facing_int(), 0))
			
	else:
		retreat[0] = 0
		
	self.interruptible_on_opponent_turn = host.combo_count > 0

func _frame_1():
	if stored_plus_frames > 0:
		host.opponent.blocked_hitbox_plus_frames = stored_plus_frames

	host.reset_momentum()

	if retreat[0] > 0:
		retreat[0] -= 1
		current_tick -= 1
		
		host.move_directly_relative("-18", "0")
		
	if !host.is_ghost:
		helljumps_used += 1
		if helljumps_used >= 10:
			$"%Stuff".unlock_achievement("SG-10HELLJUMP")
		
func _frame_2():
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
	
	host.set_grounded(false)
	
	var dir = xy_to_dir(data["Direction"].x * 1.25, data["Direction"].y, str(jump_force))
	host.apply_force(dir.x, dir.y)
	
	if host.initiative == true:
		host.start_projectile_invulnerability()

func _frame_9():
	if host.combo_count > 0:
		self.enable_interrupt()

func _tick():
	._tick()
	
	host._create_speed_after_image(Color("cc2f7b"), 0.05)
