extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var chase_dist = 130
var chase_force = 12

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.apply_force_relative("3", "-7")

func _frame_1():
	var dist_to_opp = int(host.opponent.get_pos().x - host.get_pos().x)

	host.apply_force_relative("4", "0")
	
	if host.reverse_state == false and dist_to_opp >= chase_dist:
		host.apply_force_relative(str(chase_force), "0")
