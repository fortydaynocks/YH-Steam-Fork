extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)

func _frame_2():
	host.apply_force_relative("-4", "0")

func _frame_4():
	host.start_projectile_invulnerability()

func _frame_7():
	host.apply_force_relative("8", "0")

func _frame_14():
	host.end_projectile_invulnerability()

func _tick():
	._tick()
	
	if current_tick in [9, 10, 11, 12]:
		host.reset_momentum()
		host.move_directly_relative("30", "0")
		host.apply_force_relative("8", "0")
		
	host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)
