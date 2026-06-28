extends DefaultFireball

func _enter():
	._enter()
	
	host.sprite.rotation_degrees = host.randi_range(0, 360)
