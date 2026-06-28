extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

func _frame_10():
	host.move_directly_relative("10", "0")
	host.apply_force_relative("6", "0")
