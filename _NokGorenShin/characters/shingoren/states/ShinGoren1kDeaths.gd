extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _exit():
	._exit()
	
	host.release_camera_focus()
	
func on_got_blocked():
	.on_got_blocked()
	
	host.change_state("1kdeaths2")
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and self._previous_state() and self._previous_state_name() == "demonstep":
		$"%Stuff".unlock_achievement("SG-ULT")
	
func _frame_1():
	host.grab_camera_focus()
	
	host.play_sound("SF3Super")
	host.play_sound("AK_IntroWarning")
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Pushblock.tscn"), Vector2(0, -18))

func _frame_6():
	host.play_sound("IntroAmbience")
	host.play_sound("IntroBlast")
	host.play_sound("Damage_Bass")
	
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(-host.get_facing_int(), 0), Vector2(1, 0))
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(host.get_facing_int(), 0), Vector2(-1, 0))
	
func _frame_14():
	host.play_sound("AshuraSenku")
	host.apply_force_relative("8", "0")
	
	host.colliding_with_opponent = false
	host.release_camera_focus()
	
func _frame_21():
	host.colliding_with_opponent = true
	
func _tick():
	._tick()
	
	if current_tick in [16, 17, 18, 19, 20, 21]:
		host.move_directly_relative("30", "0")
		
		var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(0, -18), vel.normalized())
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), Vector2(host.get_facing_int(), 0))
		
	if current_tick <= 14:
		host.global_hitlag(2)
		
