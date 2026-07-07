extends "res://characters/states/Idle.gd"

var _anim = 1
var _duration = 6
var _frames = 8

func _tick():
	._tick()
	
	_anim += 1

func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(_anim / _duration) % _frames
