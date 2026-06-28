extends "res://characters/states/Idle.gd"

var idle = 1
var idle_duration = 4
var idle_frames = 6

func _enter():
	._enter()
	
	if not self._previous_state_name() == self.state_name:
		idle = 1
		
	#	--	I DON'T KNOW WHY THIS ISN'T SUPERCALLING
	if auto_fall:
		if not host.is_grounded():
			return "Fall"
	if host.hp <= 0:
		return "Knockdown"

func _tick():
	._tick()
	
	idle += 1
	
	#	--	I DON'T KNOW WHY THIS ISN'T SUPERCALLING
	if auto_fall:
		if not host.is_grounded():
			return "Fall"
	if host.hp <= 0:
		return "Knockdown"
	
func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(idle / idle_duration) # % idle_frames -- TO PREVENT LOOPING
