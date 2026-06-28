extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

export (PackedScene) var slam

var loop = 0
var maxloop = 15
	
#	-------------------------------------------------------------------------------------------------------
	
var quotes = {
		"Torment": [
			"What a pitiful attempt at a clone.",
			"You should be able to take this."
		],
		#"Camila": [
			#"You already understand how this will end.",
			#"Let's see how well I've raised you."
		#],
		"Revenant": [
			"Focus on saving yourself.",
			"Your father remains my subject."
		],
		"Colossus": [
			"How dare you bite the feeding hand.",
			"Let me recalibrate you."
		],
		"Psycho": [
			"After everything, you're still useless.",
			"I shall give you hell, Mason."
			],
		"Niflheim": [
			"You impress me. Now entice me.",
			"Burn with all you've destroyed."
		],
		"Betrayer": [
			"I despise that notion of 'justice'. Die.",
			"The blade is strong but the wielder... is weak.",
		],
		"Reaper": [
			"My time has not yet come.",
			"The souls of the weak should die. Do not interfere.",
		],
		"Gentleman": [
			"Stick to the small tasks, peon.",
			"You are not worthy of even trying.",
			"Your sister is next.",
		],
		"Zeiss": [
			"The Government cannot hope to stop me.",
			"A true demon stands before you.",
			"Your brother is next.",
		],
		"_": [
			"Worthless.",
			"Inadequate.",
			"Get out of my sight.",
			"Weak.",
			"You're not worth my time.",
			"Try not to mess up the walls...",
			"Give me your life.",
			"Try to survive."
			],
	}


func do_text():
	var opp_name = host.opponent.get("charname")
	
	match opp_name:
		"Torment": return host.randi_choice(quotes.Torment)
		"Revenant": return host.randi_choice(quotes.Revenant)
		"Colossus": return host.randi_choice(quotes.Colossus)
		"Psycho": return host.randi_choice(quotes.Psycho)
		"Niflheim": return host.randi_choice(quotes.Niflheim)
		"Betrayer": return host.randi_choice(quotes.Betrayer)
		"Reaper": return host.randi_choice(quotes.Reaper)
		"Gentleman": return host.randi_choice(quotes.Gentleman)
		"Zeiss": return host.randi_choice(quotes.Zeiss)
		_: return host.randi_choice(quotes._)
	
	
#	-------------------------------------------------------------------------------------------------------
func _enter():
	._enter()
	
	host.start_invulnerability()
	loop = 0
	
func _exit():
	._exit()

func _frame_0():
	host.play_sound("Landing")
	#$"%TauntMessageLabel".text = do_text()

func _frame_15():
	host.play_sound("Crucifix")

func _frame_16():
	host.release_opponent()
	host.opponent.apply_forces_no_limit()
	
	if !host.is_ghost:
		$"%Screen".modulate = Color(1, 0, 0.27, 1)
		host.get_node("Flip").modulate = Color(0, 0, 0, 1)
		host.opponent.get_node("Flip").modulate = Color(0, 0, 0, 1)
		Global.current_game.fx_node.modulate = Color(0, 0, 0, 1)
		
		var t = create_tween().tween_property($"%Screen", "modulate", Color(1, 0, 0.27, 0), 0.5)
		var t1 = create_tween().tween_property(host.get_node("Flip"), "modulate", Color(1, 1, 1, 1), 0.5)
		var t2 = create_tween().tween_property(host.opponent.get_node("Flip"), "modulate", Color(1, 1, 1, 1), 0.5)
		var t3 = create_tween().tween_property(Global.current_game.fx_node, "modulate", Color(1, 1, 1, 1), 0.5)
		
		t.set_ease(Tween.EASE_OUT)
		t.set_trans(Tween.TRANS_EXPO)
		t1.set_ease(Tween.EASE_OUT)
		t1.set_trans(Tween.TRANS_EXPO)
		t2.set_ease(Tween.EASE_OUT)
		t2.set_trans(Tween.TRANS_EXPO)
		t3.set_ease(Tween.EASE_OUT)
		t3.set_trans(Tween.TRANS_EXPO)
		
func _frame_17():
	host.opponent.apply_force_relative("-500", "-1")
	host.opponent.apply_forces_no_limit()
	
	host.apply_force_relative("4", "0")
	host.apply_forces_no_limit()

func _tick():
	._tick()
	
	host.afterimage2(Color(1, 0, 0.27), 0.1)
	
	if current_tick >= 9:
		loop += 1
	
		if loop < maxloop:
			current_tick = 8
	
	if current_tick < 16:
		host.global_hitlag(1)
		
		host.opponent.set_facing(-host.get_facing_int())
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "WallSlam"
		host.opponent.sprite.frame = 100
		
	#	--	WALL SLAM
	var opp_state = host.opponent.current_state()
	if opp_state.state_name == "WallSlam" and opp_state.current_tick == 1:
		
		host.opponent.hitlag_ticks = 16
		host.screen_bump(Vector2(0, 0), 32, 0.1)
		host.opponent.spawn_particle_effect_relative(slam, Vector2(0, 0), Vector2(-host.opponent.get_facing_int(), 0))
		
		host.play_sound("CrucifixSlam")
		host.play_sound("CrucifixSlam2")

		opp_state.current_tick += 1

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
		
