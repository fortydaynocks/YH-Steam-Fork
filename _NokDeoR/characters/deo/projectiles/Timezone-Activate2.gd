extends ObjectState

var stopped_objects = []
var time = 2

func _frame_0():
	stopped_objects = []
	
	host.tag = "TimezoneBlast"
	host.disable_particle = null
	host.disable_sound = ""
	host.start_invulnerability()
	
	host.play_sound("Activate")
	host.spawn_particle_effect_relative(particle_scene,
	Vector2(0, 0))
		
	time = 2 + (host.stage[0] - 1)
	
func _frame_1():
	pass
	
func _tick():
	._tick()
	
	if current_tick >= 3:
		host.disable()
		
	#	--	CUSTOM OVERLAP DETECTION BECAUSE THE NORMAL ONE IS ANNOYING ME
	for hbox in host.get_active_hitboxes():
		for obj in host.objs_map.values():
			if is_instance_valid(obj) and (not obj.disabled) and (not obj.obj_name in [host.obj_name, host.get_owner().obj_name]) and (not obj.obj_name in stopped_objects) and obj.hurtbox.overlaps(hbox):
				
				#	--
				if (not "NoTimestop" in obj.editor_description):
					if obj.get("projectile_invulnerable") or obj.current_state().get("IS_NEW_PARRY"):
						if obj.is_in_group("Fighter"):
							
							obj.apply_force_relative("-2", "0")
							obj.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Star1.tscn"),
							Vector2(obj.hurtbox.x, obj.hurtbox.y))
						
					else:
						host.get_owner().stop_entity(obj, 120, "Spread")
						stopped_objects.append(obj.obj_name)
