extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

func _frame_4():
	if data.get("Summon"):
		host.summon_entity(data["Summon"], data["Placement"])
