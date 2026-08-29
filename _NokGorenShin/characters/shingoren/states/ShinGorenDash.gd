extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var initial_dist = 3
var speed = 11
var short = false

func _frame_1():
	var fac = host.get_facing_int()
	var dist = (float(data.x) / 100) * speed
	var relative_speed = (dist + initial_dist) * fac
	short = abs(float(data.x)) < 50
	
	host.apply_force_relative(str(initial_dist), "0")
	host.apply_force(str(dist), "0")
	
	#	--
	if relative_speed < 0:
		anim_name = "DashBackward"
		host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(0, 0), Vector2(-host.get_facing_int(), 0))
		
		self.backdash_iasa = true
		host.start_throw_invulnerability()
		
	else:
		anim_name = "DashForward"
		host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(0, 0), Vector2(host.get_facing_int(), 0))
		
		self.backdash_iasa = false
		
	#	--
	if short == true:
		anim_name = "Landing"
	
	host.play_sound("Dash")
	if abs(data.x) > 75:
		host.play_sound("Dash2")

func _frame_7():
	host.end_throw_invulnerability()

func _frame_9():
	if short == true and self.backdash_iasa != true: self.enable_interrupt()
		
func _tick():
	._tick()

	if current_tick in [1, 4, 7]:
		var fac = host.get_facing_int()
		var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), vel.normalized())
