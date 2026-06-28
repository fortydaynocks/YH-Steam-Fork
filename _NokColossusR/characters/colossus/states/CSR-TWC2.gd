extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

#	HITS ON FRAME 39
var chosen_text = null
var slammed = false
var as_quote_type = 0

#	--
func _exit():
	._exit()
	
	host.release_opponent()
	host.release_camera_focus()
	
	if !host.is_ghost: host.create_tween().tween_property(Global.current_game, "camera_zoom", 1.0, 0.25)
		
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		#	--	MASSIVE KNOCKBACK CORRECTION
		host.opponent.move_directly_relative("250", str(250 * 0.05))
		host.opponent.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-BigWind.tscn"), Vector2(0, 0), Vector2(-host.opponent.get_facing_int(), 0))

#	--
func _frame_0():
	slammed = false
	
	chosen_text = null
	chosen_text = $"%Stuff".choose_text(host.opponent.get("charname"), "ThisWorldCries")
	
	if !host.is_ghost: host.create_tween().tween_property(Global.current_game, "camera_zoom", 0.8, 1)
	
	host.start_invulnerability()
	host.reset_momentum()
	host.grab_camera_focus()
	
	host.apply_force_relative("2", "0")
	host.opponent.change_state("Grabbed")
	
	host.play_sound("TWC2-Fire")
	
	if $"%Stuff".skin == "Astaroth":
		as_quote_type = host.randi_range(1, 2)
		
		chosen_text = $"%Stuff".choose_text(host.opponent.get("charname"), "ThisWorldCries", $"%Stuff".quotes_asta)
	
		if as_quote_type == 1:
			host.play_sound("AS-Laugh2")
	
func _frame_6():
	if $"%Stuff".skin == "Astaroth":
		if as_quote_type == 2:
			host.play_sound("AS-NoLaugh")
	
func _frame_12():
	if chosen_text:
		$"%Stuff".do_text(chosen_text[0])
	
func _frame_21():
	if $"%Stuff".skin != "Astaroth":
		host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Misc1.tscn"), Vector2(50, -38))
	
	host.play_sound("TWC2-Fire2")
	
func _frame_22():
	host.apply_force_relative("-2", "0")
	
func _frame_23():
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameSwitch.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles2.tscn"), Vector2(0, -18))
	host.play_sound("TWC2-Fire3")
	host.play_sound("TWC2-Swing")
	
func _frame_29():
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameSwitch.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles2.tscn"), Vector2(0, -18))
	host.play_sound("TWC2-Fire3")
	
	if $"%Stuff".skin == "Astaroth":
		if as_quote_type == 1:
			host.play_sound("AS-FatalityL")
	
func _frame_31():
	host.apply_force_relative("2", "0")
	
func _frame_35():
	host.apply_force_relative("10", "0")
	
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-HitFlame.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles2.tscn"), Vector2(0, -18))
	host.play_sound("TWC2-Fire3")
	
func _frame_36():
	host.release_opponent()
	
	if chosen_text:
		$"%Stuff".do_text(chosen_text[1], 1)
	
func _frame_38():
	host.release_camera_focus()
	
	if !host.is_ghost: host.create_tween().tween_property(Global.current_game, "camera_zoom", 1.0, 0.25)
	host.play_sound("Knockback")

#	--
func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()

	if current_tick < 37:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "Getup"
		
		if current_tick < 24:
			host.opponent.sprite.animation = "Knockdown"
			
		#	--
		host.global_hitlag(1)
		
	else:
		if slammed == false and host.opponent.current_state().state_name == "WallSlam":
			slammed = true
			
			host.visible_combo_count += 1
			host.global_hitlag(20)
			host.opponent.take_damage(75, 75)
			
			host.spawn_particle_effect(preload("res://_NokColossusR/characters/colossus/effects/CSR-BigWallSlam.tscn"), Vector2(opos.x, opos.y), Vector2(host.opponent.get_facing_int(), 0))
			host.screen_bump(Vector2(0, 0), 16, 0.5)
