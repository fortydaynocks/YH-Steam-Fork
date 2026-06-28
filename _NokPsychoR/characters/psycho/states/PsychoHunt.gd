extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var _duration = 4
var _frames = 6
var _prev_sound_frame = 0

func _enter():
	._enter()
	
	if host.previous_state().state_name != "hunt":
		host.play_sound("Hunt1")
		host.play_sound("Hunt2")
		host.play_sound("Hunt3")
		host.reset_momentum()
		host.apply_force_relative("3.5", "0")
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), Vector2(host.get_facing_int(), 0))
		host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))

func _tick():
	._tick()
	
	host.run += 1
	host.apply_force_relative("0.2", "0")
	host.apply_forces_no_limit()
	
	if host.skin == 1:
		host.afterimage(Color(0, 0, 1, 0.05), 0.1)
	else:
		host.afterimage(Color(1, 0, 0, 0.05), 0.1)
	
	if $"%Stuff".skin != "Aimorrago":
		if (host.sprite.frame == 2 or host.sprite.frame == 5) and host.sprite.frame != _prev_sound_frame:
			host.play_sound("Hunt1")
			host.play_sound("Hunt2")
			host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
		
			_prev_sound_frame = host.sprite.frame
		
func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(host.run / _duration) % _frames
