extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

onready var hbox = $"%Hitbox"
var delay = [0, 5]

func _frame_0():
	delay[0] = 0
	
	if data == true:
		host.apply_force_relative("4", "0")
		host.play_sound("Warp")
		delay[0] = delay[1]
		
		hbox.plus_frames = -1
	else:
		hbox.plus_frames = 1

func _frame_3():
	host.apply_force_relative("12", "0")
	
func _frame_4():
	if data == true:
		host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar.tscn"), Vector2(0, -18))

func _tick():
	._tick()

	if current_tick == 2 and delay[0] > 0:
		delay[0] -= 1
		current_tick -= 1
		
		if delay[0] <= 0:
			host.move_directly_relative("60", "0")
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar.tscn"), Vector2(0, -18))
		
	host.afterimage(Color("#006aff"), 0.1)
	
