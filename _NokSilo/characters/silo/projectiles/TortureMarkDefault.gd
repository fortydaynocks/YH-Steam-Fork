extends ObjectState

var lifetime = 300

func _tick():
	._tick()
	
	var victim = host.objs_map[host.victim]
	if is_instance_valid(victim) and victim.disabled != true:
		var off = victim.hurtbox.y - (victim.hurtbox.height / 2.5)
		host.sprite.offset = Vector2(0, off)
		host.set_pos(victim.get_pos().x, victim.get_pos().y)
		
	else:
		host.disable()
	
	if current_tick >= lifetime:
		host.disable()
