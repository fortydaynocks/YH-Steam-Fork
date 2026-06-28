extends ObjectState

var drag = false

func _exit():
	._exit()
	
	host.sprite.rotation_degrees = 0

func _frame_0():
	host.play_sound("Fly")
	drag = false

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.get_owner().opponent:
		drag = true

func _tick_before():
	._tick_before()

	var vel = Vector2(host.get_vel().x, host.get_vel().y)
	host.set_facing(clamp(vel.x, -1, 1))
	
	vel.x *= host.get_facing_int()
	host.sprite.rotation_degrees = rad2deg(vel.angle())

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var vel = Vector2(host.get_vel().x, host.get_vel().y)
	
	#	--
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-MassBreaker.tscn"), Vector2(0, 0))
		host.rumble(4, 16)
		host.screen_bump(Vector2(0, 0), 4, 0.25)
		
		host.change_state("Slam")
		
		return
		
	if abs(pos.x) >= host.stage_width or pos.y >= host.ceiling_height:
		host.reset_momentum()
		host.apply_force_relative("-8", "-8")
		
		host.play_sound("SpinHit")
		
		host.change_state("Spin")
		
	if drag == true and host.get_owner().combo_count > 0:
		host.get_owner().opponent.set_pos(str(pos.x + vel.x), str(pos.y + vel.y))
