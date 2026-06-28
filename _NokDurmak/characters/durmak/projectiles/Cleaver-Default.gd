extends DefaultFireball

func _tick():
	._tick()
	
	if current_tick % 6 == 0:
		host.play_sound("Swing")
		
	if host.is_grounded() or abs(host.get_pos().x) >= host.stage_width:
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2())
		host.play_sound("Land")
		
		if not host.deflected:	
			host.change_state("Recoil")
		else:
			host.disable()

func _on_hit_something(obj, hitbox):
	if obj == host.get_opponent():
		if host.lodge:
			host.change_state("Lodge")
		else:
			host.change_state("Recoil")
		
func on_got_blocked():
	if host.lodge:
		host.change_state("Lodge")
	else:
		host.change_state("Recoil")
