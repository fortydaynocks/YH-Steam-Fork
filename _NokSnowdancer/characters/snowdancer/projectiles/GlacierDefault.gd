extends DefaultFireball

func _tick():
	._tick()
	
	if is_instance_valid($"%ParticleEffect"):
		host.sprite.rotation_degrees = rad2deg(Vector2(int(host.get_vel().x), int(host.get_vel().y)).angle())
		$"%ParticleEffect".rotation_degrees = host.sprite.rotation_degrees
