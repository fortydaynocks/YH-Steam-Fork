extends "res://_NokGentleman/characters/gentleman/states/GentlemanTrip.gd"

func _frame_35():
	host.afterimage(host.colors_table.MainColor, 0.5)

func _frame_38():
	host.apply_force_relative("-8", "0")
	host.change_stance_to("Recline")

func _tick():
	._tick()
	
	host.afterimage(host.colors_table.MainColor, 0.1)
