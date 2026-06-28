extends "res://_NokSkullmage/characters/skullmage/projectiles/summons/SK-SummonState.gd"

export (int) var move_speed = 10
export (String) var anim_dash_f = "DashForward"
export (String) var anim_dash_b = "DashBackward"

func _frame_1():
	if not data:
		return "Default"
		
	host.reset_momentum()
		
	var dir = xy_to_dir(data.x, data.y, str(move_speed))
	host.apply_force(dir.x, dir.y)
	
	self.anim_name = anim_dash_f if data.x * host.get_facing_int() > 0 else anim_dash_b
