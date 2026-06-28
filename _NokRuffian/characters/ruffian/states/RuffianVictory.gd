extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

export (PackedScene) var rose

func _enter():
	._enter()
	var voiceline = host.randi_range(1, 3)
	if voiceline == 1:
		host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00017.wav"), -6)
	elif voiceline == 2:
		host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00016.wav"), -6)
	else:
		host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00019.wav"), -6)

func _tick():
	._tick()
	if host.opponent.hp <= 0:
		endless = true
	else:
		endless = false

func _frame_8():
	var fac = host.get_facing_int()
	
	var obj = host.spawn_object(rose, 16, -48, true, null, true)
	obj.set_grounded(false)
	obj.apply_force(str(12 * fac), "-12")
