extends "res://_NokDurmak/characters/durmak/summons/WalkerState.gd"

var tp_speed = 15

func _tick():
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
		
	if current_tick in [3, 4, 5, 6, 7, 8, 9, 10]:
		host.move_directly(str(tp_speed if opos.x > pos.x else -tp_speed), "0")
