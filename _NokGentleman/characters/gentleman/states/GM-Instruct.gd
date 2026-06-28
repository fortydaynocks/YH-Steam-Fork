extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var commanding = false
var influence = 5

func _enter():
	._enter()
	
	commanding = false

func _frame_2():
	if data.get("Agent") and host.obj_from_name(data["Agent"]):
		host.obj_from_name(data["Agent"]).spawn_particle_effect_relative(preload("res://_NokGentleman/characters/gentleman/effects/GM_Misc1.tscn"), Vector2(0, -18))
		
		if data.get("Action"):
			commanding = true
			host.obj_from_name(data["Agent"]).change_state("ready", data["Action"])
			
			var dir = xy_to_dir(host.current_di.x, host.current_di.y, str(influence))
			host.obj_from_name(data["Agent"]).apply_force(dir.x, dir.y)

func _frame_7():
	if host.combo_count >= 1 and commanding:
		self.enable_interrupt()
