extends "res://_NokBetrayer/characters/betrayer/projectiles/knight/KOO-State.gd"

func _frame_1():
	var opos = host.get_owner().opponent.get_pos()
	host.set_pos(str(opos.x), str(host.get_pos().y))
	host.move_directly_relative("-40", "0")
	
	host.apply_force_relative("12", "0")
