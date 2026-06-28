extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var _frame = 0
var _duration = 6
var _frames = 5
var _prev_sound_frame = 0

var speed = 3

func _tick():
	._tick()
	
	_frame += 1
	
	if current_tick % 2 == 1:
		host.gain_super_meter(1)
	
	host.has_projectile_armor = host.fortitude.Value >= 100
	
	#	--
	if abs(int(host.get_vel().x)) < speed:
		host.set_vel(str(speed * host.get_facing_int()), host.get_vel().y)
	
	if (host.sprite.frame == 1) and host.sprite.frame != _prev_sound_frame:
		_prev_sound_frame = host.sprite.frame
		
		host.play_sound("Step")
		host.screen_bump(Vector2(0, 0), 2, 0.1)
		
	if (host.sprite.frame == 2) and host.sprite.frame != _prev_sound_frame:
		_prev_sound_frame = host.sprite.frame
		
		host.play_sound("Move" + str(host.randi_range(1, 3)))

func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(_frame / _duration) % _frames
