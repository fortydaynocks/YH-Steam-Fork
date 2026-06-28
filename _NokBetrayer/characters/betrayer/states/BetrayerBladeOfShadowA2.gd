extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _enter():
	._enter()
	
	host.reset_momentum()
	host.apply_force_relative("4", "-4")
	
func _frame_12():
	host.reset_momentum()
	
	host.move_directly_relative("-24", "-24")
	host.apply_force_relative("-8", "-8")
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)

	if obj == host.opponent:
		if "Bleed" in hitbox.misc_data:
			host.bleed += 25
	
func _tick():
	._tick()
	
	if current_tick in [8, 9, 10]:
		host.global_hitlag(1)
		
	host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)
