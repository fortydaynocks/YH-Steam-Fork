extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func is_usable():
	return .is_usable() and host.portalspikes <= 0 and host.portalspike_cooldown <= 0

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		host.portalspikes += 4
