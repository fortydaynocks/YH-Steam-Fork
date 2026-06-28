extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var usf = 0
var usf_duration = 4
var usf_frames = 6

func _enter():
	._enter()
	
	if not self._previous_state_name() == self.state_name:
		usf = 0
	
	host.change_stance_to("Recline")
	
func _exit():
	._exit()
	
	host.change_stance_to("Normal")
	
func _tick():
	._tick()

	usf += 1
	host.gain_super_meter(2)

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = clamp(int(usf / usf_duration), 0, usf_frames)
