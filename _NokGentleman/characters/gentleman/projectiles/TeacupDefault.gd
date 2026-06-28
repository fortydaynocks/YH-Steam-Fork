extends ObjectState

func _tick():
	._tick()
	
	if host.is_grounded() == true or abs(float(host.get_pos().x)) >= host.stage_width or abs(float(host.get_pos().y)) >= host.ceiling_height:
		host.change_state("Break")
		
	if current_tick % 8 == 1:
		host.play_sound("Spin")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.get_owner().opponent:
		host.change_state("Break")
		
	host.get_owner().activate_item("Brass Knuckle", hitbox)
