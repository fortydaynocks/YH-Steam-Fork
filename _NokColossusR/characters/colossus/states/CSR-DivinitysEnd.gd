extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var blade = preload("res://_NokColossusR/characters/colossus/projectiles/EndBlade.tscn")
var force = 6
var blade_force = 20

func is_usable():
	var found_objs = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == host:
			if obj.get("tag") == "EndBlade":
				found_objs += 1
	
	return .is_usable() and found_objs < 1

func _frame_5():
	host.reset_momentum()
	
	if $"%Stuff".skin == "Astaroth":
		host.play_sound("AS-OverHere")
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-EarthShake.tscn"), Vector2(0, 0))
		host.play_sound("BigJump")
		
	var dir = xy_to_dir(data.x, data.y, str(force))
	host.apply_force_relative("0", "-10")
	host.apply_force(dir.x, dir.y)
	host.apply_forces_no_limit()
	
func _frame_20():
	host.reset_momentum()
	host.apply_force_relative("-4", "-4")

	var obj = host.spawn_object(blade, 28, 0, true, null, true)
	obj.set_grounded(false)
	obj.apply_force(str(blade_force * host.get_facing_int()), str(blade_force))
	obj.sprite.material = host.sprite.material
	
	host.end_blade = obj.obj_name

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if current_tick >= 5 and current_tick < 21:
		host.afterimage(Color("#c0cbdc"), 0.05)
		
		if current_tick < 18:
			host.global_hitlag(1)
		
	if current_tick in [7, 8, 9, 10, 11, 12, 13]:
		host.opponent.hitlag_ticks = 1
