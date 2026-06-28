extends "res://characters/states/Idle.gd"

var idle_duration = 6
var idle_frames = 4

func _tick():
	._tick()
	
	host.idle += 1

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(host.idle / idle_duration) % idle_frames
