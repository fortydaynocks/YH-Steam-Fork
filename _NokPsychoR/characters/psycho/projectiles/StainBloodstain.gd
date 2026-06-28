extends ObjectState

onready var redknife = preload("res://_NokPsychoR/characters/psycho/projectiles/RedKnife.tscn")

func _frame_0():
	host.play_sound("Bloodstream")
	host.play_sound("Bloodstream2")
	
	var pos = host.get_pos()
	var k1 = host.creator.spawn_object(redknife, pos.x, pos.y, false, null, false)
	var k2 = host.creator.spawn_object(redknife, pos.x, pos.y, false, null, false)
	var k3 = host.creator.spawn_object(redknife, pos.x, pos.y, false, null, false)
	
	k1.set_grounded(false)
	k2.set_grounded(false)
	k3.set_grounded(false)
	
	k1.apply_force("-12", "4")
	k2.apply_force("12", "4")
	k3.apply_force("0", "-8")

func _tick():
	._tick()
	
	if current_tick >= 5:
		host.disable()
