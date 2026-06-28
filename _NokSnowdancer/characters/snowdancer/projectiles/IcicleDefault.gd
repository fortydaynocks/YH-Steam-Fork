extends DefaultFireball

func _tick():
	._tick()
	
	host.sprite.rotation = Vector2(float(host.get_vel().x), float(host.get_vel().y)).normalized().angle()
