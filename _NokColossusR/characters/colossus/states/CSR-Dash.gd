extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var initial_dist = 2
var speed = 8
var backwards = "F"

func _frame_0():
	var fac = host.get_facing_int()
	var dist = ((float(data.x) / 100) * speed) + (initial_dist * fac)
	backwards = dist * fac <= 0
	
	host.apply_force(str(dist), "0")
		
	if backwards == false:
		anim_name = "DashForward"
	else:
		anim_name = "DashBackward"
		host.start_throw_invulnerability()
		
	self.backdash_iasa = backwards
	
func _frame_1():
	pass
	
func _frame_7():
	host.end_throw_invulnerability()
		
func _tick():
	._tick()
	
	if current_tick % 2 == 0:
		host.afterimage(Color("#e6e6e6"), 0.05)

	if current_tick in [1, 4]:
		var fac = host.get_facing_int()
		var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), vel.normalized())
