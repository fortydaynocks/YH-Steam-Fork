extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _frame_4():
	host.play_sound("MakeWeapon")
	
func _frame_9():
	host.apply_force_relative("12", "0")
	
func _tick():
	._tick()
	
	if current_tick in [9, 10, 11]:
		host.move_directly_relative("20", "0")

	if current_tick % 2 == 0:
		host.afterimage(host.colors.Fire, 0.1)

func on_got_blocked_by(who):
	.on_got_blocked_by(who)
	
	if who is Fighter:
		host.play_sound("HowDareYouBlock")
		host.change_state("graciousterror2")
