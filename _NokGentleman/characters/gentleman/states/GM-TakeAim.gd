extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

onready var mark = preload("res://_NokGentleman/characters/gentleman/projectiles/Mark.tscn")
var mark_range = 200

#	--
func is_usable():
	return .is_usable() and host.has_item("Countermeasures")

func _frame_4():
	var dir = xy_to_dir(data.x, data.y, str(mark_range))
	var obj = host.spawn_object(mark, int(dir.x), int(dir.y) -  18, false, null, true)
