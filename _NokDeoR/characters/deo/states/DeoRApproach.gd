extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

var sprite_frame = 0

var duration = 6
var frames = 8
var prev_sound_frame = -1

func _tick():
	._tick()
	
	sprite_frame += 1
	host.gain_super_meter(1)

	if (host.sprite.frame == 1 or host.sprite.frame == 5) and host.sprite.frame != prev_sound_frame:
		host.play_sound("Walk1")
		prev_sound_frame = host.sprite.frame
		
	if (host.sprite.frame == 3 or host.sprite.frame == 7) and host.sprite.frame != prev_sound_frame:
		host.play_sound("Walk2")
		prev_sound_frame = host.sprite.frame


func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(sprite_frame / duration) % frames

func _frame_1():
	host.reset_momentum()
	host.apply_force_relative(str(3), "0")
