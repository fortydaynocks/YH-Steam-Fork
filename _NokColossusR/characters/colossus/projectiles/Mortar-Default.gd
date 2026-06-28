extends ObjectState

var accel = 0.4

func _tick():
	._tick()
	
	var pos = host.get_pos()
	
	if current_tick > 1:
		host.move_directly_relative("0", "8")
	
	if host.is_grounded() == true:
		var obj = host.get_owner().spawn_object(preload("res://_NokColossusR/characters/colossus/projectiles/HolyFire.tscn"), pos.x, pos.y, false, null, false)
		obj.set_grounded(false)
		obj.width = 75
		obj.lifetime = 30
		
		$"%afterimage".emitting = false
		$"%flame".emitting = false
		
		host.change_state("Blast")
		#host.disable()
	
	#if host.get_vel().x == "0" and host.get_vel().y == "0":
		#host.apply_force_relative("1", "0")
		
	#else:
		#var vec = Vector2(host.get_vel().x, host.get_vel().y).normalized()
		
		#host.apply_force(str(accel * vec.x), str(accel * vec.y))
		#host.sprite.rotation_degrees = rad2deg(vec.angle())
		
	#if host.is_grounded() == true:
		#host.move_directly_relative("0", "-1")
		#host.set_vel("0", str(-int(host.get_vel().y)))
		
	#if current_tick >= 20:
		#self.fizzle()

#func _on_hit_something(obj, _hitbox):
	#._on_hit_something(obj, _hitbox)
	
	#fizzle()
	
#func fizzle():
	#$"%flame".emitting = false
	#host.change_state("Blast")
	
#func detect(obj):
	#.detect(obj)
	
	#if obj == host.get_owner().opponent:
		#fizzle()
