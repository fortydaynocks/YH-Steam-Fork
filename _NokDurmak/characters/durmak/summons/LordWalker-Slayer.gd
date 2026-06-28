extends "res://_NokDurmak/characters/durmak/summons/WalkerState.gd"

func _frame_15():
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
	host.set_facing(1 if opos.x > pos.x else -1)
