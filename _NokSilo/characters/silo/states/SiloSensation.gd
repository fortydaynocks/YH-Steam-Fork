extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var dist = 150
var gap = 40

#func _frame_8():
	#if is_instance_valid(host.opponent):
		#host.opponent.grab_camera_focus()
	
#func _exit():
	#._exit()
	
	#if is_instance_valid(host.opponent):
		#host.opponent.release_camera_focus()

func _frame_1():
	host.stress += 0.08

func _tick():
	._tick()
	
	var dir = xy_to_dir(data.x, data.y, "100")
	var tpos = Vector2(float(host.get_pos().x) + float(dir.x), float(host.get_pos().y) + float(dir.y))
	
	if current_tick in [1, 4, 7]:
		host.spawn_particle_effect(host.vfx_table.Slash, tpos)
	
	if current_tick > 6 and current_tick <= 34:
		for obj in host.objs_map.values():
			if is_instance_valid(obj) and obj.disabled != true:
				if obj == host or (obj.get("creator") == host and obj.get("wretchedeye") == true):
					pass
					
				else:
					obj.hitlag_ticks = 1
	
	if current_tick == 8:
		host.play_sound("Sensation")
		
		var eye = host.spawn_object(host.objs_table.WretchedEye, tpos.x + 100, tpos.y, false, null, false)
		host.eyes.append(eye.obj_name)
		
	if current_tick == 12:
		host.play_sound("Sensation")
		
		var eye = host.spawn_object(host.objs_table.WretchedEye, tpos.x - 100, tpos.y, false, null, false)
		host.eyes.append(eye.obj_name)
		
	if current_tick == 16:
		host.play_sound("Sensation")
		
		var eye = host.spawn_object(host.objs_table.WretchedEye, tpos.x + 70, tpos.y - 70, false, null, false)
		host.eyes.append(eye.obj_name)
		
	if current_tick == 20:
		host.play_sound("Sensation")
		
		var eye = host.spawn_object(host.objs_table.WretchedEye, tpos.x - 70, tpos.y - 70, false, null, false)
		host.eyes.append(eye.obj_name)
		
	if current_tick == 24:
		host.play_sound("Sensation")
		
		var eye = host.spawn_object(host.objs_table.WretchedEye, tpos.x, tpos.y - 100, false, null, false)
		host.eyes.append(eye.obj_name)

