extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var target = null

func _enter():
	._enter()
	
	target = null

func _frame_9():
	if target:
		var target_obj = host.objs_map[target]
		
		if is_instance_valid(target_obj):
			var tpos = target_obj.get_pos()
			
			host.reset_momentum()
			host.set_pos(str(tpos.x), str(tpos.y))
			host.move_directly_relative("65", "0")
			host.apply_force_relative("10", "0")
		
	else:
		host.move_directly_relative("80", "0")
		host.apply_force_relative("10", "0")
		
		host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)
		
		if host.is_grounded() == true:
			host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))

func _frame_14():
	host.move_directly_relative("-30", "0")
	host.apply_force_relative("-16", "0")

func detect(obj):
	.detect(obj)
	
	if obj == host.opponent:
		host.spawn_particle_effect_relative(self.particle_scene, Vector2(0, -24))
		target = obj.obj_name
		
func _tick():
	._tick()
	
	if target:
		if current_tick in [10, 11, 12, 13, 14]:
			host.global_hitlag(2)
			
	host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)
			
	
