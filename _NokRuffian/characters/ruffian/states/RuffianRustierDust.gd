extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

onready var hbox = $"HitboxRusty"

func _frame_1():
	var dist = data.x
	
	if is_instance_valid(hbox):
		hbox.x = 60 + dist

func _frame_6():
	host.spawn_particle_effect_relative(preload("res://_NokRuffian/characters/ruffian/effects/RFRustedDust_Air.tscn"), Vector2(hbox.x, hbox.y + 8))
	host.spawn_particle_effect_relative(preload("res://_NokRuffian/characters/ruffian/effects/TileExplode.tscn"), Vector2(hbox.x, 0))
