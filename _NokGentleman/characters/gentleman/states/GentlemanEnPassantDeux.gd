extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var target = null

func is_usable():
	return .is_usable() and host.has_item("Pocket Knife")

func _enter():
	._enter()
	
	target = null

func _frame_1():
	host.use_item("Pocket Knife")

func _frame_2():
	host.apply_force_relative("-6", "0")

func detect(obj):
	.detect(obj)
	
	if obj == host.opponent:
		
		host.play_sound("EnPassantFind")
		host.spawn_particle_effect_relative(host.vfx_table.KnifeFlash, Vector2(0, -28))
		target = obj.obj_name
			
		
func _tick():
	._tick()

	if current_tick in [10, 14]:
		host.global_hitlag(1)
		
		if target:
			var target_obj = host.objs_map[target]
			
			if is_instance_valid(target_obj):
				var tpos = target_obj.get_pos()
				
				host.reset_momentum()
				host.set_pos(str(tpos.x), str(tpos.y))
				host.move_directly_relative("40", "0")
				host.apply_force_relative("10", "0")
			
		else:
			host.move_directly_relative("80", "0")
			host.apply_force_relative("10", "0")
			
			host.afterimage(host.colors_table.MainColor, 0.1)
			
			if host.is_grounded() == true:
				host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
				
	if current_tick == 12:
		host.global_hitlag(1)
		
		if target:
			var target_obj = host.objs_map[target]
			
			if is_instance_valid(target_obj):
				var tpos = target_obj.get_pos()
				
				host.reset_momentum()
				host.set_pos(str(tpos.x), str(tpos.y))
				host.move_directly_relative("-40", "0")
				host.apply_force_relative("-10", "0")
			
		else:
			host.move_directly_relative("-80", "0")
			host.apply_force_relative("-10", "0")
			
			host.afterimage(host.colors_table.MainColor, 0.1)
			
			if host.is_grounded() == true:
				host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
