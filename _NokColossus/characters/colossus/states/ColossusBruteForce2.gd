extends ThrowState

export (Array, Vector2) var new_throw_positions

func _frame_1():
	pass
	
	#for pos in throw_positions.keys():
		#print(pos)

func _tick():
	._tick()
	
	
	
	if current_tick <= 34:
		host.global_hitlag(1)

	#if current_tick >= 15 and current_tick < 32:
		#host.opponent.sprite.animation = "WallSlam"
