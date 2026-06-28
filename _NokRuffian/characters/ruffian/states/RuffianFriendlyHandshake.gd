extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

onready var tbox = $ThrowBox
var out_of_combo = false

func _enter():
	._enter()
	out_of_combo = false
	if host.combo_count <= 0:
		tbox.hits_vs_aerial = not host.is_grounded()
		tbox.hits_vs_grounded = host.is_grounded()
	else:
		tbox.hits_vs_aerial = true
		tbox.hits_vs_grounded = true

func _frame_1():
	if host.initiative:
		host.start_throw_invulnerability()
		host.start_projectile_invulnerability()

func _frame_2():
	if data:
		host.apply_force_relative(data.x/5, 0)

func _tick():
	._tick()
	if current_tick == tbox.start_tick - 1:
		if host.opponent.current_state().name == "Getup" or host.combo_count <= 0:
			out_of_combo = true

	if out_of_combo == true:
		tbox.hits_vs_aerial = not host.is_grounded()
		tbox.hits_vs_grounded = host.is_grounded()

	
func _frame_9():
	host.end_projectile_invulnerability()
	host.end_throw_invulnerability()
