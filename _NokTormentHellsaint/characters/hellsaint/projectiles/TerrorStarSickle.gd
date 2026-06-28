extends DefaultFireball

func on_got_blocked():
	.on_got_blocked()
	
	num_hits -= 1
	
	if num_hits == 0:
		fizzle()

func _frame_0():
	host.projectile_immune = false

func _tick():
	._tick()
	
	if current_tick % 6 == 0:
		host.play_sound("SickleSpin")
		
	if current_tick % 12 == 0:
		host.play_sound("SickleSpin2")

	var force = host.xy_to_dir(host.get_owner().current_di.x, host.get_owner().current_di.y, "0.7")
	host.apply_force(force.x, force.y)
