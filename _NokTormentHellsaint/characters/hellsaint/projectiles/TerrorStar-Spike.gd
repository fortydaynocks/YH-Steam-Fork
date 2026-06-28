extends DefaultFireball

func _frame_0():
	host.projectile_immune = false

func _tick():
	._tick()
	
	var vec = Vector2(host.get_vel().x, host.get_vel().y).normalized()
	vec.x *= host.get_facing_int()
	var angle = vec.angle()
	
	host.sprite.rotation_degrees = rad2deg(angle) + 45

	if host.is_grounded():
		host.get_owner().spawn_array(host.get_pos())
		host.disable_particle = null
		host.disable()
