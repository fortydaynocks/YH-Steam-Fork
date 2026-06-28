extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _enter():
	._enter()
	
	host.start_invulnerability()
	
func _exit():
	._exit()
	
	host.end_invulnerability()
	
func _frame_38():
	host.reset_momentum()
	host.apply_force_relative("20", "0")
	
func _frame_48():
	host.reset_momentum()
	host.apply_force_relative("-40", "0")
	
func _frame_52():
	host.reset_momentum()
	host.apply_force_relative("40", "0")

func _tick():
	._tick()
	
	host.afterimage(Color(1, 0, 0, 1), 0.1)
