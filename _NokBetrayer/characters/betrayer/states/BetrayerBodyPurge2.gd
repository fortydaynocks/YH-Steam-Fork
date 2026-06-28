extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _frame_1():
	host.bleed += 40

func _tick():
	._tick()
	
	if current_tick in [11, 12, 13, 14]:
		self.offset_x = -27
		self.offset_y = -10
		
	elif current_tick in [15, 16, 17, 18]:
		self.offset_x = -18
		self.offset_y = -6
		
	elif current_tick in [19, 20]:
		self.offset_x = 4
		self.offset_y = 2
		
	elif current_tick in [21, 22]:
		self.offset_x = 28
		self.offset_y = 2
		
	else:
		self.offset_x = -30
		self.offset_y = -12
