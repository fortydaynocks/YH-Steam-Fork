extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_4():
	host.insight = true
	host.insight_eyes_spawned = 6

func _frame_6():
	host.insight_star_ticks.append(host.realtick + 1)
	host.insight_star_ticks.append(host.realtick + 21)
	host.insight_star_ticks.append(host.realtick + 41)
