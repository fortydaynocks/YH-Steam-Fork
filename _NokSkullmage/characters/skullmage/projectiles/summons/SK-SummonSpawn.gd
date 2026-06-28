extends "res://_NokSkullmage/characters/skullmage/projectiles/summons/SK-SummonState.gd"

func _enter():
	._enter()
	
	host.start_invulnerability()
