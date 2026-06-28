extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var mod_max = 3

func _frame_2():
	if not "Aerial" in self.editor_description:
		host.apply_force_relative("2", "-4")
	
func _frame_6():
	host.set_grounded(false)
	host.apply_force_relative("4", "0")

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8]:
		var mod = clamp(host.opponent.get_pos().y - host.get_pos().y, -mod_max, mod_max)
		
		host.move_directly_relative("10", str(mod))
		host.afterimage(host.extra_color_2, 0.05)
