extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

export (PackedScene) var end_blade

func _frame_1():
	if host.skin == 1 and is_instance_valid($"%AstaEmote"):
		if host.asta_emote_tween:
			host.asta_emote_tween.kill()
		
		$"%AstaEmote".bbcode_text = "[center]" + host.randi_choice(host.asta_emotes.DivinitysEnd)
		$"%AstaEmote".percent_visible = float(0)
		$"%AstaEmote".modulate = Color(1, 1, 1, 1)
		
		host.asta_emote_tween = create_tween()
		host.asta_emote_tween.tween_property($"%AstaEmote", "percent_visible", float(1), 0.2)
		host.asta_emote_tween.tween_property($"%AstaEmote", "modulate", Color(1, 1, 1, 0), 1)

func _frame_3():
	host.reset_momentum()
	
	var dir = xy_to_dir(data.x * 1.5, data.y * 0.75, "20")
	
	host.apply_force_relative("20", "-20")
	host.apply_force(dir.x, dir.y)
	
func _frame_20():
	host.screen_bump(Vector2(0, 0), 6, 0.25)
	
	host.spawn_object(end_blade, 0, 0, true, null, true)
