extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		if host.opponent.hp <= 0:
			host.play_sound("MetalPipe")

	host.do_asta_text(host.asta_emotes.WideSlash, 0.2, 1)
