extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"
	
func _enter():
	._enter()
	
	host.start_throw_invulnerability()
	host.start_projectile_invulnerability()
	
func _frame_1():
	var dir = data.x
	
	host.apply_force(str(float(data.x * 16)), "0")
	
	if float(host.get_vel().x) * host.get_facing_int() <= 0 :
		anim_name = "weavebackward"
		iasa_at = 20
	else:
		anim_name = "weaveforward"
		iasa_at = 19

func _frame_2():
	host.start_invulnerability()

func _frame_9():
	host.end_invulnerability()
	host.end_throw_invulnerability()
	host.end_projectile_invulnerability()

