extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var rift = preload("res://_NokBetrayer/characters/betrayer/projectiles/OrderRift.tscn")
var dist = 150

func is_usable():
	var found_rifts = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.get_owner() == host and obj.get("disabled") != true and obj.get("tag") == "OrderRift":
			found_rifts += 1
	
	return .is_usable() and found_rifts < 1

func _frame_8():
	var obj = host.spawn_object(rift, dist, -18, true, null, true)
	
	obj.set_grounded(false)
	obj.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1.tscn"), Vector2(0, 0))
	obj.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1.tscn"), Vector2(0, 0))

	if $"%Stuff".skin == "Munanyou":
		host.play_sound("Mu-Thunder1")

func _tick():
	._tick()

	host.afterimage(Color("#006aff"), 0.1)
