extends DirProjectileDefault

func _tick():
	._tick()
	
	#if is_instance_valid($"%slash"):
		#$"%slash".scale.x = host.get_facing_int()
		#$"%slash".rotation_degrees = host.sprite.rotation_degrees
