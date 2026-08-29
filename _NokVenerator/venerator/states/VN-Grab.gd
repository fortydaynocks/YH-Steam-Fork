extends "res://characters/states/Grab.gd"

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and host.blessings.grab[0] < 1:
		host.gain_blessing()
		host.blessings.grab[0] = host.blessings.grab[1]
