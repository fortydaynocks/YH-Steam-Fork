extends "res://_NokJupiter/characters/jupiter/states/JupiterState.gd"

var max_adj = 3

func _frame_6():
	host.apply_force_relative("8", "0")
	
	if "Aerial" in self.editor_description:
		host.apply_force_relative("0", str(clamp(host.opponent.get_pos().y - host.get_pos().y, -max_adj, max_adj)))

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8]:
		host.move_directly_relative("20", "0")
		
		if "Aerial" in self.editor_description:
			host.move_directly_relative("0", str(clamp(host.opponent.get_pos().y - host.get_pos().y, -max_adj, max_adj)))
			
		#	--
		host.afterimage(host.stuff.colors.Charge2, 0.1)
