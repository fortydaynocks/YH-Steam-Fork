extends "res://_NokBetrayer/characters/betrayer/projectiles/knight/KOO-State.gd"

var order_wave = preload("res://_NokBetrayer/characters/betrayer/projectiles/OrderWave.tscn")

func _frame_9():
	var pos = host.get_pos()
	var proj = host.get_owner().spawn_object(order_wave, pos.x, pos.y - 18, true, null, false)
	
	proj.set_grounded(false)
	proj.set_facing(host.get_facing_int())
	
	proj.apply_force_relative("5", "2")
