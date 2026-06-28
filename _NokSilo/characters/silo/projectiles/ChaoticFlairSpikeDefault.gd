extends ObjectState

export  var _c_Projectile_Dir = 0
export  var move_speed = "15.0"

export  var _c_Homing_Options = 0
export  var homing = false
export  var homing_turn_speed = "3.0"
export  var homing_accel = "1.0"
export  var max_homing_speed = "10"
export  var start_homing = false
export  var lifetime = 99999
export  var relative_data_dir = false
export  var clash = true
export  var num_hits = 1
export  var fizzle_on_ground = true
export  var bounce_on_ground = false
export  var num_bounces = 2

var hit_something = false
var hit_something_tick = 0
var last_y_vel = "0"

var stop_at = 6
var last_pos: Vector2

func _frame_0():
	hit_something = false
	hit_something_tick = 0
	host.set_grounded(false)
	if homing:
		if start_homing:
			var dir = data["dir"]
			var move_vec = fixed.vec_mul(str(dir.x), str(dir.y), move_speed)
			host.apply_force(move_vec.x, move_vec.y)
		else :
			host.apply_force_relative(move_speed, "0.01")

func _tick():
	._tick()
	
	if current_tick <= stop_at:
		var pos = host.get_pos()
		host.update_grounded()
		
		var vel = host.get_vel()
		if not fixed.eq(vel.y, "0"):
			last_y_vel = vel.y
		
		elif not hit_something:
			var dir
			if not homing:
				dir = data["dir"]
				var dir_x = fixed.mul(dir.x, str(host.get_facing_int())) if relative_data_dir else dir.x
				var move_vec = fixed.normalized_vec_times(dir_x, str(dir.y), move_speed)
		
				host.move_directly(move_vec.x, move_vec.y)
				host.sprite.rotation = float(fixed.vec_to_angle(dir.x, dir.y))
				host.particles.rotation = float(fixed.vec_to_angle(dir.x, dir.y))
				host.set_facing(fixed.sign(dir_x))
			else :
				var opponent = host.get_opponent()
				if opponent == null:
					return 
				var target = host.obj_local_center(opponent)
				var current = fixed.normalized_vec(vel.x, vel.y)
				var desired = fixed.normalized_vec(str(target.x), str(target.y))
				var steering_x = fixed.sub(desired.x, current.x)
				var steering_y = fixed.sub(desired.y, current.y)
				var steer_force = fixed.normalized_vec_times(steering_x, steering_y, homing_turn_speed)
				var force_x = fixed.mul(current.x, homing_accel)
				var force_y = fixed.mul(current.y, homing_accel)
				if not fixed.eq(vel.x, "0"):
					host.set_facing(1 if fixed.gt(vel.x, "0") else - 1)
				host.apply_force(force_x, force_y)
				host.apply_force(steer_force.x, steer_force.y)
				host.apply_forces()
				
				host.update_data()
				var new_vel = host.get_vel()
				if fixed.gt(fixed.vec_len(new_vel.x, new_vel.y), max_homing_speed):
					var clamped_vel = fixed.normalized_vec_times(new_vel.x, new_vel.y, max_homing_speed)
					host.set_vel(clamped_vel.x, clamped_vel.y)
				host.sprite.rotation = float(fixed.vec_to_angle(fixed.mul(new_vel.x, str(host.get_facing_int())), new_vel.y))

	#if current_tick >= 30:
		#fizzle()
		
	#	--
	var current_pos = Vector2(host.get_pos().x, host.get_pos().y)
	
	if not last_pos:
		last_pos = current_pos
		
	if is_instance_valid($"%Spike"):
		var point_pos = Vector2(current_pos.x - last_pos.x, current_pos.y - last_pos.y)
		$"%Spike".points.append(point_pos)
	last_pos = current_pos

func fizzle():
	host.disable()
