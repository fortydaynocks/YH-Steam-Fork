extends "res://_NokSnowdancer/characters/snowdancer/states/SD-Frozen.gd"
	
var brace = [0, 1]
	
func _enter():
	._enter()
	
	var pos = host.get_pos()
	
	#	--
	host.rumble(1, 4)
	host.opponent.spawn_particle_effect(preload("res://_NokSnowdancer/characters/snowdancer/effects/SD_Pray.tscn"), Vector2(pos.x, pos.y + host.sprite.offset.y))

func _frame_0():
	brace = [0, 1]
	if data: brace = data.Timing
