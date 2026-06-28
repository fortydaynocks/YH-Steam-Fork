extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var walk = 1
var walk_duration = 6
var walk_frames = 8
var prev_sound_frame = -1

func _tick():
	._tick()
	
	walk += 1
	host.gain_super_meter(1)

	if (host.sprite.frame == 0 or host.sprite.frame == 4) and host.sprite.frame != prev_sound_frame:
		host.play_sound("walk")
		host.play_sound("walkbass")
		prev_sound_frame = host.sprite.frame

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(walk / walk_duration) % walk_frames

func _frame_1():
	host.apply_force_relative(str(3.5), "0")
	
	
