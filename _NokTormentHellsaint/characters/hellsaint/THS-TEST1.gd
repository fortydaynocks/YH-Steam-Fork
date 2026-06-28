extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_1():
	host.apply_force_relative("-8", "0")
	
func _frame_3():
	self.switch_animation("crucifix", 2)
	
func _frame_5():
	self.switch_animation("crucifix", 2)
	
func _frame_8():
	self.switch_animation("rampage", 7)
	host.apply_force_relative("12", "0")
	
func _tick():
	._tick()
	
	if current_tick in [8, 9, 10, 11]:
		host.move_directly_relative("30", "0")
