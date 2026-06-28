extends DefaultFireball

func _tick():
	._tick()
	
	var vel = Vector2(host.get_vel().x, host.get_vel().y)
	
	if floor(vel.length()) > 0:
		host.sprite.rotation_degrees = rad2deg(vel.angle())
