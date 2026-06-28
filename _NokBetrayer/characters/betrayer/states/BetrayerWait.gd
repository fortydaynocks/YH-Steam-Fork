extends CharacterState

export  var auto_fall = true

var idle_duration = 4
var idle_frames = 6
var idle_frame = 1

func _enter():
	if auto_fall:
		if not host.is_grounded():
			return "Fall"

func _tick():
	host.apply_fric()
	host.apply_forces()

	if auto_fall:
		if not host.is_grounded():
			return "Fall"
	if host.hp <= 0:
		return "Knockdown"
		
	#	--
	idle_frame += 1


func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(idle_frame / idle_duration) % idle_frames
		
