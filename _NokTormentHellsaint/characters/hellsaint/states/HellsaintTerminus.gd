extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

export (StreamTexture) var iconC

func init():
	.init()
	
	if not $"%Stuff".skin == "Camila":
		self.title = "Ultimate Aston: Terminus"

func is_usable():
	return .is_usable() and host.terminus == false

func _enter():
	._enter()
	
	host.play_sound("terminus_heartbeat")
	host.play_sound("terminus_bassdrop")

func _exit():
	._exit()
	
	host.release_camera_focus()

func _frame_1():
	host.grab_camera_focus()
	
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Laugh4")
	
	if $"%Stuff".skin == "Camila":
		$"%Stuff".do_text($"%Stuff".choose_text("Terminus", $"%Stuff".quotes_cml))
		
	else:
		$"%Stuff".do_text($"%Stuff".choose_text("Terminus", $"%Stuff".quotes_tor))

func _frame_4():
	host.start_invulnerability()

func _frame_17():
	host.play_sound("terminus_crack")
	
	if !host.is_ghost:
		host.spawn_particle_effect_relative(host.vfx_table.Crack, Vector2(0, -26))
		host.global_hitlag(15, true)

func _frame_18():
	host.end_invulnerability()
	host.terminus_time += 840
	host.toggle_terminus(true)
	
	host.reset_momentum()
	host.release_camera_focus()
	host.update_facing()
	
	host.spawn_particle_effect_relative(host.vfx_table.Terminus, Vector2(0, -18))
	host.screen_bump(Vector2(0, 0), 16, 0.5)
	
	host.play_sound("terminus_shatter")
	host.play_sound("terminus_explosion")
	host.play_sound("terminus_ambience")

	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Terminus")
	else:
		host.play_sound("terminus_ambience2")
		
	#var obj1 = host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/TerrorStar.tscn"), 0, -36, true, null, true)
	#var obj2 = host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/TerrorStar.tscn"), 0, -36, true, null, true)
	#var obj3 = host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/TerrorStar.tscn"), 0, -36, true, null, true)
	#var obj4 = host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/TerrorStar.tscn"), 0, -36, true, null, true)
	#var obj5 = host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/TerrorStar.tscn"), 0, -36, true, null, true)
		
	#obj1.apply_force("0", "-5")
	#obj2.apply_force("2", "-4")
	#obj3.apply_force("-2", "-4")
	#obj4.apply_force("4", "-3")
	#obj5.apply_force("-4", "-3")
		
func _frame_24():
	if host.combo_count >= 1:
		enable_interrupt()
		host.end_invulnerability()
		
func _tick():
	._tick()
	
	if host.combo_count >= 1:
		if current_tick % 2 == 0:
			host.opponent.hitlag_ticks = 1
	
	if current_tick <= 12:
		host.global_hitlag(2, true)
