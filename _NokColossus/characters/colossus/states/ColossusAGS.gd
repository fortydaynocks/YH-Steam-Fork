extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

export (PackedScene) var godwave

func _frame_1():
	if host.skin == 1 and is_instance_valid($"%AstaEmote"):
		if host.asta_emote_tween:
			host.asta_emote_tween.kill()
		
		$"%AstaEmote".text = "[center]" + host.randi_choice(host.asta_emotes.AresGodSlicer)
		$"%AstaEmote".percent_visible = float(0)
		$"%AstaEmote".modulate = Color(1, 1, 1, 1)
		
		host.asta_emote_tween = create_tween()
		host.asta_emote_tween.tween_property($"%AstaEmote", "percent_visible", float(1), 0.2)
		host.asta_emote_tween.tween_property($"%AstaEmote", "modulate", Color(1, 1, 1, 0), 1)

func _frame_18():
	var fac = host.get_facing_int()
	var obj = host.spawn_object(godwave, 48, 0, true, null, true)
	obj.set_grounded(false)
	obj.set_facing(host.get_facing_int())
	obj.apply_force(str(8 * fac), "0")

func _tick():
	._tick()
	
	if current_tick <= 13:
		host.global_hitlag(1)
