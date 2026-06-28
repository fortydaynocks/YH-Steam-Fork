extends "res://_NokBetrayer/characters/betrayer/projectiles/knight/KOO-State.gd"

func detect(obj):
	.detect(obj)
	
	if obj == host.get_owner().opponent:
		host.change_state("Acumen2")
