extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _enter():
	._enter()
	
	apply_grav = true

func _frame_8():
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
	var facing = host.get_facing_int()
	
	host.set_pos(str(float(opos.x) - (8 * host.get_facing_int())), str(opos.y))
	host.set_vel(ovel.x, ovel.y)
	host.update_facing()

func _frame_14():
	host.apply_force_relative("6", "0")
	
func _frame_28():
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
	var facing = host.get_facing_int()
	
	host.set_pos(str(float(opos.x) - (32 * host.get_facing_int())), str(float(opos.y) + 32))
	host.set_vel(ovel.x, ovel.y)
	host.apply_force_relative("6", "-6")
	host.update_facing()

func _frame_42():
	host.reset_momentum()
	apply_grav = false
	
	host.apply_force_relative("24", "24")

func _tick():
	._tick()
	
	if current_tick >= 42:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
			
		host.opponent.set_vel(0, 0)
		host.opponent.move_directly(str((pos.x + (32 * host.get_facing_int()) - opos.x) / 2.5), str((pos.y - (-32 + 18) - opos.y) / 2.5))
		
		if host.is_grounded() == true:
			host.reset_momentum()
			host.apply_force_relative("8", "0")
			return "flaminghellfinisher"
