extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var force = 6

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.apply_force_relative("0", "-6")

func _frame_1():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	host.apply_force_relative("0", "6")
	if host.is_grounded(): vec.y = 0
	host.apply_force(str(vec.x * force), str(vec.y * force))
	
func _tick():
	._tick()
	
	if current_tick < 8:
		host.global_hitlag(1)
