extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var throw_speed = 16
var spread = 10

func is_usable():
	return .is_usable() and host.has_item("Tea Set")

func _enter():
	host.use_item("Tea Set")

func _frame_4():
	var obj1 = host.spawn_object(host.objs_table.Teacup, 18, -18, true, null, true)
	var obj2 = host.spawn_object(host.objs_table.Teacup, 18, -18, true, null, true)
	var obj3 = host.spawn_object(host.objs_table.Teacup, 18, -18, true, null, true)
	
	var dir_base = Vector2(float(data.x), float(data.y))
	var dir_base2 = dir_base.rotated(deg2rad(spread))
	var dir_base3 = dir_base.rotated(deg2rad(-spread))
	
	var dir = xy_to_dir(dir_base.x, dir_base.y, str(throw_speed))
	var dir2 = xy_to_dir(dir_base2.x, dir_base2.y, str(throw_speed))
	var dir3 = xy_to_dir(dir_base3.x, dir_base3.y, str(throw_speed))
	
	obj1.set_grounded(false)
	obj1.apply_force(dir.x, dir.y)
	
	obj2.set_grounded(false)
	obj2.apply_force(dir2.x, dir2.y)
	
	obj3.set_grounded(false)
	obj3.apply_force(dir3.x, dir3.y)
	
	
