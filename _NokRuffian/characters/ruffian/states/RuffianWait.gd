extends "res://characters/states/Idle.gd"

var idle_duration = 6
var idle_frames = 48

func _tick():

	
	host.idle += 1
	return ._tick()

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(host.idle / idle_duration) % idle_frames
