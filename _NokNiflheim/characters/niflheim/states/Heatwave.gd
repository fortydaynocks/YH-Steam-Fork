extends CharacterState

export var _c_heatwave = 0
export (float) var heatwave_config_speed
export (float) var heatwave_y_modifier

var dashdir = "fwd"

export (PackedScene) var dash_particle_fwd
export (PackedScene) var dash_particle_bwd


func _enter():
	var dir = xy_to_dir(data.x, data.y * heatwave_y_modifier, str(heatwave_config_speed))
	host.apply_force(dir.x, dir.y)
	
func _frame_1():
	if float(host.get_vel().x) * host.get_facing_int() <= 0 :
		anim_name = "dashbackwardnew"	
	else:
		anim_name = "dashforwardnew"
	
	if float(host.get_vel().x) <= 0:
		host.spawn_particle_effect_relative(dash_particle_bwd, Vector2(0, -18))
		
	else:
		host.spawn_particle_effect_relative(dash_particle_fwd, Vector2(0, -18))

func _frame_12():
	apply_grav = true
	apply_fric = true
