extends "res://_NokVenerator/venerator/states/VN-State.gd"

var interrupt_time = [0, 12]
var interrupt_after = 13

var force = 1.5
var redirected = [1, 1]
var redirect_force = 12
var redirect_times = 1
var max_redirect_times = 1

func on_interrupt():
	.on_interrupt()
	
	interrupt_time[0] = 0
	
	
func _frame_0():
	interrupt_time[0] = 0
	
	redirected[0] = redirected[1]
	redirect_times = max_redirect_times
	
	if host.combo_count > 0:
		current_tick = 11
	
func _frame_2():
	host.apply_force_relative("-4", "-4")
	
func _tick():
	._tick()
	
	#if current_tick == interrupt_after:
		#self.enable_interrupt()
		
	if current_tick >= interrupt_after:
		interrupt_time[0] += 1
		if interrupt_time [0] >= interrupt_time[1]:
			self.enable_interrupt()
			
		#self.interruptible_on_opponent_turn = true
			
		#self.interruptible_on_opponent_turn = false
		
	#	--
	if current_tick >= 12:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()

		if current_tick == 12:
			host.reset_momentum()
			host.apply_force(str(vec.x * 2), str(vec.y * 2))
		else:
			host.update_facing()
			host.apply_force(str(vec.x * force), str(vec.y * force))
			
		if current_tick % 4 == 0:
			var fac = host.get_facing_int()
			var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
			host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), vel.normalized())
			
			host.afterimage(Color("#8f8f8f"), 0.1)
		
		if redirect_times > 0:
			if !(host.current_di.x == 0 and host.current_di.y == 0):
				redirect_times -= 1
				
				host.reset_momentum()
				host.use_air_movement()
				
				var dir = xy_to_dir(host.current_di.x, host.current_di.y, str(redirect_force))
				host.apply_force(dir.x, dir.y)
				
				host.spawn_particle_effect_relative(preload("res://_NokVenerator/venerator/effects/VN-Star1.tscn"), Vector2(0, -18))
				host.play_sound("Voyage-Redirect")
				
				host.afterimage(Color("#8f8f8f"), 0.25)
