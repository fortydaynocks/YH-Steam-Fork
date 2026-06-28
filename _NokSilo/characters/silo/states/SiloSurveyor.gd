extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var init = 125
var dist = 125

func _frame_6():
	var dir = ((float(data.x) / 100) * dist) + init
	
	host.spawn_object(host.objs_table.Surveyor, dir, -host.get_pos().y, true, null, true)
