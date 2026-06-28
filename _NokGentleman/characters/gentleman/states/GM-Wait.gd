extends "res://characters/states/Idle.gd"

func _enter():
	._enter()
	
	match host.stance:
		"Blackridge":
			return "br-idle"
			
		"Recline":
			return "recline"
