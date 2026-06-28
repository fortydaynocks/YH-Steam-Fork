extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var force = 6

func _frame_1():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	if host.is_grounded(): vec.y = 0
	host.apply_force(str(vec.x * force), str(vec.y * force))
	
func _tick():
	._tick()
	
	if current_tick < 3:
		host.global_hitlag(1)
