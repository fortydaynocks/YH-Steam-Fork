extends "res://_NokSkullmage/characters/skullmage/projectiles/summons/SK-SummonDefault.gd"

var hover_dist = 40

func _tick():
	._tick()
	
	if host.get_pos().y > -hover_dist:
		host.apply_force_relative("0", "-0.1")
