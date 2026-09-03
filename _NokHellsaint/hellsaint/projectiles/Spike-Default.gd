extends DefaultFireball

var acc = 1
var bounces = 1

#	--
func touching_which_wall():
	var col_box = host.get_collision_box()
	var vel = host.get_vel()
	var bounce = 0

	if (col_box.x1 <= -host.stage_width and fixed.le(vel.x, "0")):
		bounce = -1
	elif (col_box.x2 >= host.stage_width and fixed.ge(vel.x, "0")):
		bounce = 1
		
	return bounce

#	--
func _tick():
	._tick()
	
	#if data.get("norm"):
		#host.apply_force(str(data.norm.x * acc), str(data.norm.y * 0.5))
