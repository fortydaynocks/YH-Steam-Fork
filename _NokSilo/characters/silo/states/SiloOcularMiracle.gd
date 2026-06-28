extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func _frame_3():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	#var spos = Vector2(float((opos.x) + float(pos.x)) / 2, (float(opos.y) + float(pos.y)) / 2)
	var dir = xy_to_dir(data.x, data.y, "100")
	
	var eye = host.spawn_object(host.objs_table.WretchedEye, pos.x + float(dir.x), (pos.y + float(dir.y)) - 18, false, null, false)
	host.eyes.append(eye.obj_name)

	eye.follow_target = host.obj_name
	eye.follow_offset = Vector2(float(dir.x), float(dir.y) - 18)

	host.stress += 0.04
