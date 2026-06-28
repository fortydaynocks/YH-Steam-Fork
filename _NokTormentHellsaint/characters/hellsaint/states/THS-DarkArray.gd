extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var array = preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Array.tscn")
var dist = 150
var initial_dist = 50

func is_usable():
	return .is_usable() and len(host.get_spike_arrays()) < 3

func _frame_4():
	var dir = ((float(data.x) / 100) * dist) + initial_dist
	
	var proj = host.spawn_object(array, dir, 0, true, null, true)
	proj.set_grounded(true)
	proj.set_facing(host.randi_choice([-1, 1]))
	proj.set_pos(str(proj.get_pos().x), "0")

func _frame_9():
	if host.opponent.current_state() is ParryState or host.combo_count > 0:
		self.enable_interrupt()
