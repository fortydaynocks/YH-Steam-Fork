extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

onready var h = $Hitbox
onready var h2 = $Hitbox2


func _frame_0():
	if data:
		if data == true:
			host.apply_force_relative(2, 6)

func _tick():
	._tick()
	if data:
		if data == true and current_tick == Utils.int_clamp(current_tick, 2, 5):
			host.move_directly_relative(1, 2)

	var opdi = host.opponent.current_di
	if opdi.y < 0:
		h.di_modifier = "0.25"
		h2.di_modifier = "0.25"
	else:
		h.di_modifier = "1.0"
		h2.di_modifier = "1.0"
