extends ObjectState

func _tick():
	if host.creator:
		host.set_pos(host.creator.opponent.get_pos().x, host.creator.opponent.get_pos().y - 18)
	
		if current_tick % 9 == 0:
			host.creator.opponent.take_damage(1)

		if host.spawn_data:
			host.sprite.rotation = host.spawn_data["sprrot"] - 45
			
		if current_tick >= 90:
			host.disable()
			terminate_hitboxes()
