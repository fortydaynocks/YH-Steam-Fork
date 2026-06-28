extends CharacterState


func _enter():
	if not host.is_grounded():
		return "Fall"

func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(host.idle_anim/4)%11


func _tick():
	host.idle_anim += 1	
	if not host.is_grounded():
		return "Fall"
	if host.hp <= 0:
		return "Knockdown"
