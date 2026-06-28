extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var chase = 1

func _frame_0():
	if data:
		host.apply_force_relative("-4", "4")
		
	else:
		host.apply_force_relative("4", "-4")
		
func _frame_11():
	host.set_grounded(false)

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if current_tick < 11:
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		host.apply_force(str(vec.x * chase), str(vec.y * chase))
