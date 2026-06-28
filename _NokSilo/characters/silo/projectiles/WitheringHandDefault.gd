extends DefaultFireball

func _enter():
	._enter()
	
	host.sprite.rotation_degrees = host.randi_range(0, 360)
	host.sprite.flip_h = host.randi_choice([true, false])
