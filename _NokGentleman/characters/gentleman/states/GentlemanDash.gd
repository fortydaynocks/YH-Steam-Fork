extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

export (int) var initial_dist = 4
export (int) var speed = 14

func _frame_1():
	var fac = host.get_facing_int()
	var dist = ((float(data.x) / 100) * speed) + (initial_dist * fac)
	host.apply_force(str(dist), "0")
		
	if dist * fac >= 0:
		anim_name = "DashForward"
	else:
		anim_name = "DashBackward"
		
	self.backdash_iasa = (dist * fac <= -((speed - initial_dist) / 2))
		
func _tick():
	._tick()
	
	if current_tick % 2 == 0:
		host.afterimage(host.colors_table.MainColor, 0.05)

	if current_tick in [1, 4]:
		var fac = host.get_facing_int()
		var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), vel.normalized())
