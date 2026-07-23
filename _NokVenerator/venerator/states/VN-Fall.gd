extends "res://characters/states/Fall.gd"

var idle_duration = 4
var idle_frames = 5
var idle_frame = 1

func _enter():
	._enter()
	
	if self._previous_state_name() != self.state_name:
		idle_frame = 1

func _tick_before():
	._tick_before()
	
	idle_frame += 1
	
	if int(host.get_vel().y) < 5:
		self.anim_name = "Fall2"
	else:
		self.anim_name = "Fall"
	
func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(idle_frame / idle_duration) % idle_frames
