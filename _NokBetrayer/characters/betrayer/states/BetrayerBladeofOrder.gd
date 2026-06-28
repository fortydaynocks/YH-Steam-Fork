extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var speed = 20

func _frame_6():
	var dir = xy_to_dir(data.x, data.y, str(speed))
	
	var obj = host.spawn_object(host.objs_table.OrderSlash, 30, -24, true, null, true)
	obj.set_grounded(false)
	obj.apply_force(dir.x, dir.y)
	obj.sprite.material = host.sprite.material
