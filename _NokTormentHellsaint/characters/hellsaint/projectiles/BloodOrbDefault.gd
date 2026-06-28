extends DefaultFireball

func _enter():
	._enter()
	
	host.set_facing(1)

func _create_speed_after_image(color:Color = Color.white, lifetime = 0.2):
	var speed_image_effect = preload("res://fx/SpeedImageEffect.tscn")
	var texture = host.sprite.frames.get_frame(host.sprite.animation, host.sprite.frame)
	var effect = host._spawn_particle_effect(speed_image_effect, host.get_pos_visual() + host.sprite.offset)
	effect.set_texture(texture)
	effect.lifetime = lifetime
	effect.set_color(color)
	effect.sprite.flip_h = host.get_facing_int() == - 1

func _tick():
	._tick()
	
	_create_speed_after_image(Color.red, 0.05)
	
	self.apply_custom_x_fric = current_tick < 32
	self.apply_custom_y_fric = current_tick < 32

func _frame_32():
	host.reset_momentum()
	
	var pos = host.get_pos()
	var opos = host.creator.opponent.get_pos()
	
	var mov_vec = Vector2(opos.x - pos.x, (opos.y - 18) - pos.y).normalized()
	var mov_rot = mov_vec.angle()
	host.apply_force(str(mov_vec.x * 20), str(mov_vec.y * 20))
	
	host.sprite.rotation = mov_rot
	
	#	--
	
	fizzle_on_ground = true
	fizzle_on_walls = true
	host.fizzle_on_ceiling = true
	
func fizzle():
	if host.is_grounded() == true:
		var pos = host.get_pos()
		host.creator.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Spike.tscn"), pos.x, pos.y, false, null, false)
	
	.fizzle()
