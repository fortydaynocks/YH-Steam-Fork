extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var speed = 1.25

func _tick():
	._tick()
	
	if current_tick in [9, 10]:
		host.global_hitlag(2)
		
	if current_tick < 12 and "Aerial" in self.editor_description:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		if host.is_grounded() == true: vec.y = 0
		
		host.apply_force(str(vec.x * speed), str(vec.y * speed))
	
