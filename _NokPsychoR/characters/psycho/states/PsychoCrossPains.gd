extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _tick():
	._tick()
	
	host.afterimage(Color(1, 0, 0, 0.75), 0.1)

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if host.wounds < host.minimum_h_wounds:
		host.wounds += 15
		
func on_got_blocked():
	.on_got_blocked()
	
	host.scars += 12
