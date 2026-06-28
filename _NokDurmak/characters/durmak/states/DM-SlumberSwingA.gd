extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var force = 11

func _frame_1():
	host.reset_momentum()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var ovel = Vector2(host.opponent.get_vel().x, host.opponent.get_vel().y)
	
	var vec = Vector2((opos.x - ovel.x) - pos.x, (opos.y - ovel.y) - pos.y).normalized()
	if host.is_grounded(): vec.y = 0
	host.apply_force(str(vec.x * force), str(vec.y * force))
	
	if host.is_grounded():
		host.apply_force_relative("0", "-4")
	
func _frame_8():
	host.apply_force_relative("0", "8")
	host.set_grounded(false)
	
func _tick():
	._tick()
	
	if current_tick < 9:
		host.global_hitlag(1)
