extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _frame_0():
	host.start_invulnerability()

func _frame_1():
	host.opponent.sprite.z_index - 1

func _frame_11():
	host.apply_force_relative("4", "0")
	host.release_opponent()
	
	host.bleed += 40
	
func _frame_12():
	host.opponent.change_state("Grabbed")

func _frame_23():
	host.apply_force_relative("-4", "0")
	host.release_opponent()
