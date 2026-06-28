extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var array = preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Array.tscn")
var max_dist = -180
var forced_block = false

func is_usable():
	return .is_usable() and host.get_pos().y >= max_dist

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost1")
	
func _frame_12():
	if host.is_grounded() == false:
		host.spawn_particle_effect_relative(host.vfx_table.Flash, Vector2(0, -18))
		host.set_pos(str(host.get_pos().x), "0")
		
	var proj = host.spawn_object(array, 70, 0, true, null, true)
	proj.set_grounded(true)
	proj.set_facing(1)
	proj.set_pos(str(proj.get_pos().x), "0")
	
	var proj2 = host.spawn_object(array, -70, 0, true, null, true)
	proj2.set_grounded(true)
	proj2.set_facing(-1)
	proj2.set_pos(str(proj2.get_pos().x), "0")
		
#	--
func _tick():
	._tick()
	
	self.apply_custom_x_fric = host.is_grounded() == false
	self.apply_custom_y_fric = host.is_grounded() == false
	
	if host.terminus == true and host.is_grounded() == true:
		if current_tick == 5:
			host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Spike.tscn"), 40, 0, true, null, true)
			host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Spike.tscn"), -40, 0, true, null, true)
				
		if current_tick == 9:
			host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Spike.tscn"), 80, 0, true, null, true)
			host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Spike.tscn"), -80, 0, true, null, true)
			
	if current_tick < 13:
		host.global_hitlag(1)
		
	#	--	FORCEBLOCK ARMOUR
	if current_tick in [4, 5, 6, 7, 8, 9, 10, 11]:
		host.has_hyper_armor = true
	
	if current_tick == 12:
		host.has_hyper_armor = false
	
	if host.has_hyper_armor:
		if host.opponent.current_state().get("hit_fighter") == true:
			if forced_block == false:
				forced_block = true
				
				host.opponent.change_state("ParryAuto")
	else:
		forced_block = false
