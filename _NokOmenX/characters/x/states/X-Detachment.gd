extends "res://_NokOmenX/characters/x/states/X-State.gd"

func _frame_4():
	if int(host.distance_to(host.opponent)) > 30:
		host.apply_force_relative("12", "0")
		
		host.afterimage(Color("#ff0000"), 0.1)	
