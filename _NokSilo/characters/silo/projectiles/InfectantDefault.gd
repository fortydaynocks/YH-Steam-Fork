extends DefaultFireball

func _tick():
	._tick()
	
	host.sprite.rotation = Vector2(float(host.get_vel().x), float(host.get_vel().y)).angle()
	host._create_speed_after_image(Color.red, 0.1)
