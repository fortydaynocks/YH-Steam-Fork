extends "res://characters/states/OffensiveBurst.gd"

func is_usable():
	return .is_usable() and host.current_state().hit_fighter == true

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		host.lordflame.Value += 3
