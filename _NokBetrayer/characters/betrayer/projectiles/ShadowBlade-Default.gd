extends DefaultFireball

var shoot_speed = 20

func _frame_28():
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()

	host.sprite.rotation_degrees = rad2deg(vec.angle())

func _frame_30():
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	host.apply_force(str(vec.x * shoot_speed), str(vec.y * shoot_speed))
	
func _tick():
	._tick()
	
	if current_tick == 30:
		host.play_sound("Split")
		
		self.apply_custom_x_fric = false
		self.apply_custom_y_fric = false
