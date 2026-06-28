extends DefaultFireball

var chase_speed = 0.75

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var cpos = host.get_owner().get_pos()
	var vel = host.get_vel()
	
	#	--	HOMING
	var vec = Vector2(cpos.x - pos.x, (cpos.y - pos.y) - 18).normalized()
	host.apply_force(str(vec.x * chase_speed), str(vec.y * chase_speed))
	
	if host.hurtbox.overlaps(host.get_owner().hurtbox) or host.get_owner().opponent.combo_count > 0:
		host.play_sound("Vanish")
		
		host.disable()
	
