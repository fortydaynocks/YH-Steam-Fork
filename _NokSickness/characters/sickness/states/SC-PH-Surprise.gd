extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

var speed = 20

func _frame_0():
	host.opponent.hitlag_ticks += 6
	
func _frame_3():
	host.start_invulnerability()
	
func _frame_11():
	host.end_invulnerability()
	host.reset_momentum()
	
	host.apply_force_relative("8", "0")

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8, 9, 10, 11]:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		if host.is_grounded() == true: vec.y = 0
		
		host.move_directly(str(vec.x * speed), str(vec.y * speed))

	if current_tick in [10, 11]:
		host.global_hitlag(2)
