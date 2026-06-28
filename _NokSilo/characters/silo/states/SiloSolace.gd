extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var init = 100
var dist = 100

func _frame_3():
	var dir = ((float(data.x) / 100) * dist) + init
	
	var obj = host.spawn_object(host.objs_table.Bloodflower, (12 + dir) * host.get_facing_int(), -float(host.get_pos().y), false, null, true)
	host.bloodflowers.append(obj.obj_name)

func _frame_7():
	if host.combo_count >= 1:
		self.enable_interrupt()
