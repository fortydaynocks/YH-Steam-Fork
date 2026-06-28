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

var deflections = 2
var last_deflected_by_hitbox = null

var wheel_target

func _enter():
	._enter()

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

	#	--	FLOWER RETARGETING
	var closest_flower = host.creator.get_closest_flower(host)
	
	if closest_flower:
		wheel_target = closest_flower
	else:
		wheel_target = host.creator.opponent
	
	#	--
	var pos = host.get_pos()
	host.update_grounded()
	
	var vel = host.get_vel()
	if not fixed.eq(vel.y, "0"):
		last_y_vel = vel.y
	
	if host.is_grounded() and bounce_on_ground:
		host.set_grounded(false)
		host.move_directly(0, - 1)
		if vel:
			host.set_vel(vel.x, fixed.mul(fixed.abs(last_y_vel), "-0.75"))
		num_bounces -= 1
		if num_bounces < 0:
			fizzle()
	
	if current_tick > lifetime:
		fizzle()
		host.hurtbox.width = 0
		host.hurtbox.height = 0
	
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
			var target = host.obj_local_center(wheel_target)
			var current = fixed.normalized_vec(vel.x, vel.y)
			var desired = fixed.normalized_vec(str(target.x), str(target.y))
			var steering_x = fixed.sub(desired.x, current.x)
			var steering_y = fixed.sub(desired.y, current.y)
			var steer_force = fixed.normalized_vec_times(steering_x, steering_y, homing_turn_speed)
			var force_x = fixed.mul(current.x, homing_accel)
			var force_y = fixed.mul(current.y, homing_accel)
			
			#	NO FACING CHANGE (that was here)
				
			host.apply_force(force_x, force_y)
			host.apply_force(steer_force.x, steer_force.y)
			host.apply_forces()
			
			host.update_data()
			var new_vel = host.get_vel()
			if fixed.gt(fixed.vec_len(new_vel.x, new_vel.y), max_homing_speed):
				var clamped_vel = fixed.normalized_vec_times(new_vel.x, new_vel.y, max_homing_speed)
				host.set_vel(clamped_vel.x, clamped_vel.y)
			
			#	NO SPRITE ROTATION (that was here)

			#	--	DEFLECTION	
			for hbox in host.creator.opponent.get_active_hitboxes():
				if hbox.hits_projectiles == true:
					if hbox.overlaps(host.hurtbox):
						host.reset_momentum()
						var opos = host.creator.opponent.get_pos()
						var mul = 0.75
						
						var vec = Vector2(float(pos.x) - float(opos.x), float(opos.y) - float(pos.y)).normalized()
						host.apply_force(str((vec.x * float(hbox.knockback)) * mul), str((vec.x * float(hbox.knockback)) * mul))

						host.creator.opponent.projectile_free_cancel()
						host.creator.opponent.start_projectile_invulnerability()
						
						if hbox != last_deflected_by_hitbox:
							deflections -= 1
							last_deflected_by_hitbox = hbox
						
							host.play_sound("Deflect")
							host.spawn_particle_effect_relative(particle_scene, Vector2(0, 0))
							
							if deflections <= 0:
								host.play_sound("Deflect2")
								host.spawn_particle_effect_relative(timed_particle_scene, Vector2(0, 0))
								
								host.disable()
						
		#	--
		for eye in host.creator.eyes:
			var eye_obj = host.objs_map[eye]
			if is_instance_valid(eye_obj):
				if host.hurtbox.overlaps(eye_obj.hurtbox):
					if eye_obj.disabled != true and eye_obj.current_state().state_name != "Activate" and eye_obj.current_state().current_tick >= 14:
						eye_obj.change_state("Activate")
			
						
func _got_parried():
	if homing:
		fizzle()

func fizzle():
	hit_something = true
	host.disable()
	terminate_hitboxes()
	hit_something_tick = current_tick

func _on_hit_something(obj, _hitbox):
	if clash:
		if obj is BaseProjectile:
			if not obj.deletes_other_projectiles:
				return 
		num_hits -= 1
		if num_hits == 0:
			fizzle()

#	--
func detect(obj):
	if obj == host.creator.opponent:
		
		if float(host.get_pos().x) >= float(host.creator.opponent.get_pos().x):
			host.set_facing(-1)
		else:
			host.set_facing(1)
		
		host.change_state("Grind")
