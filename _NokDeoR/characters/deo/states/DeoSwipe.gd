extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func _frame_1():
	if "Aerial" in self.editor_description:
		if data == true:
			host.apply_force_relative("0", "6")

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
	
	if current_tick <= 7:
		var force_x = clamp(opos.x - pos.x, -0.5, 0.5)
		var force_y = clamp(opos.y - pos.y, -0.5, 0.5)
		
		host.apply_force(str(force_x), str(force_y))
