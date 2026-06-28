extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _tick():
	._tick()
	
	if current_tick <= 8:
		host.global_hitlag(1)

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	host.do_asta_text(host.asta_emotes.Falter, 0.2, 1)
