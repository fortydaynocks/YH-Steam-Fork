extends "res://_NokSkullmage/characters/skullmage/projectiles/summons/SK-SummonSpawn.gd"

func _tick():
	._tick()
	
	host.set_pos(str(host.get_pos().x), "0")
