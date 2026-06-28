extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var walk = 1
var walk_duration = 8
var walk_frames = 8
var prev_sound_frame = -1

func _tick():
	._tick()
	
	walk += 1
	host.gain_super_meter(1)

	if (host.sprite.frame == 0 or host.sprite.frame == 4) and host.sprite.frame != prev_sound_frame:
		host.play_sound("step" + str(host.randi_range(1, 3)))
		host.play_sound("step-bass")
		
		host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(0, -18), Vector2(host.get_facing_int(), 0))
		host.screen_bump(Vector2(), 1.0, 0.1)
		
		#	--
		prev_sound_frame = host.sprite.frame
		
	if (host.sprite.frame == 2 or host.sprite.frame == 6) and host.sprite.frame != prev_sound_frame:
		host.play_sound("step-swing")
		
		prev_sound_frame = host.sprite.frame

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(walk / walk_duration) % walk_frames

func _frame_1():
	host.apply_force_relative(str(3), "0")
