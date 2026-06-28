extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

onready var hbox = $"%HitboxFable"

func _enter():
	._enter()

	if is_instance_valid(hbox):
		if data.x in [1, -1] and data.y == -1:
			hbox.x = 55
			hbox.y = -65
		
		if data.x in [1, -1] and data.y == -0:
			hbox.x = 65
			hbox.y = -20
			
		if data.x in [1, -1] and data.y == 1:
			hbox.x = 65
			hbox.y = 25
			
