extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_8():
	host.reset_momentum()
	
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
	var offset = Vector2(40, -60)
	
	host.set_pos(str((float(opos.x) + (offset.x * host.get_facing_int()))), str(float(opos.y) + offset.y))
	host.set_vel(ovel.x, ovel.y)
	
	host.apply_force_relative("-4", "6")

func _frame_14():
	host.reset_momentum()
	host.apply_force_relative("2", "-4")
