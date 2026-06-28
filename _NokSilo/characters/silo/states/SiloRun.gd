extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var _duration = 3
var _frames = 10
var prev_sound_frame = -1

func _tick():
	._tick()
	
	host.apply_force_relative("2", "0")
	
	host.run += 1
	host.gain_super_meter(1)

	if host.vip.skin != "Sinestrosa":
		if (host.sprite.frame == 0 or host.sprite.frame == 5) and host.sprite.frame != prev_sound_frame:
			host.play_sound("Run1")
			prev_sound_frame = host.sprite.frame

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(host.run / _duration) % _frames
