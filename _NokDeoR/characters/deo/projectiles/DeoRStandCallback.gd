extends "res://_NokDeoR/characters/deo/projectiles/DeoRStandState.gd"

func _enter():
	host.start_invulnerability()

func _frame_1():
	host.can_disable = true
	host.disable()
