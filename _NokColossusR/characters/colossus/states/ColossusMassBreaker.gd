extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var chase_speed = 1
var dist = 100

func _frame_6():
	if host.is_grounded() == true and (not "ReqFlame" in self.editor_description):
		host.apply_force_relative("6", "0")

func _frame_15():
	if "ReqFlame" in self.editor_description:
		var obj = host.spawn_object(preload("res://_NokColossusR/characters/colossus/projectiles/HolyFire.tscn"), 100, 0, true, null, true)
		obj.set_grounded(false)
		obj.width = 100
	
	var dir = (float(data.x) / 100) * dist
	dir += dist
	
	host.spawn_quake_limited(dir)

func _tick():
	._tick()
	
	if current_tick <= 8 and "ReqFlame" in self.editor_description:
		var dist = clamp(host.opponent.get_pos().x - host.get_pos().x, -chase_speed, chase_speed)
		host.apply_force(str(dist), "0")
		
	if current_tick in [11, 12, 13, 14] and host.is_grounded() == true:
		host.global_hitlag(2)
	
	if current_tick < 15 and host.is_grounded() == false:
		if current_tick >= 12:
			current_tick -= 1
			
		host.apply_force_relative("0", "2")
		
	if "ReqFlame" in self.editor_description:
		host.afterimage(Color(1, 1, 1, 0.5), 0.1)
