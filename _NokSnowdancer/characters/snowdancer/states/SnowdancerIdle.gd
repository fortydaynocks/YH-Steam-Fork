extends "res://characters/states/Idle.gd"

var frame = 1

var duration = 4
var frames = 4

func _tick():
	._tick()
	
	frame += 1
	self.anim_name = "Wait2" if host.elegant_storm >= 1 else "Wait"

func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(frame / duration) % frames
