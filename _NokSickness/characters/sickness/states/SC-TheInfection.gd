extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

onready var hbox = $ThrowBox
var speed = 0.4

func _frame_1():
	if is_instance_valid(hbox):
		hbox.hits_vs_aerial = not host.is_grounded()
		hbox.hits_vs_standing = not hbox.hits_vs_aerial
		hbox.hits_vs_grounded = not hbox.hits_vs_aerial
		

func _tick():
	._tick()
	
	if current_tick < 24:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		if host.is_grounded() == true: vec.y = 0
		
		host.apply_force(str(vec.x * speed), str(vec.y * speed))
