extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func _frame_12():
	var angle = Vector2(host.get_facing_int(), 0).rotated(deg2rad(-10 * host.get_facing_int()))
	host.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-SpaceRipper.tscn"), Vector2(0, -28), angle)
