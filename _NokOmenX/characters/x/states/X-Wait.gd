extends "res://characters/states/Idle.gd"

var sprite_frame = 1

var duration = 4
var frames = 20

func _tick():
	._tick()
	
	sprite_frame += 1

func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(sprite_frame / duration) % frames

