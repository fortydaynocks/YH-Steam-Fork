extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

var walk_duration = 4
var walk_frames = 8
var prev_sound_frame = 0

func _tick():
	._tick()
	
	host.walk += 1
	
	if (host.sprite.frame == 4) and host.sprite.frame != prev_sound_frame:
		prev_sound_frame = host.sprite.frame
		host.play_sound("Step")
		host.screen_bump(Vector2(0, 0), 4, 0.1)
		
	if (host.sprite.frame == 6 or host.sprite.frame == 1) and host.sprite.frame != prev_sound_frame:
		prev_sound_frame = host.sprite.frame
		host.play_sound("Move" + str(host.randi_range(1, 5)))

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(host.walk / walk_duration) % walk_frames
