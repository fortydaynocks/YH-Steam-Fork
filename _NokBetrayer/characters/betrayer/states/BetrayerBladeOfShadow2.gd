extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _enter():
	._enter()
	
	host.reset_momentum()
	host.apply_force_relative("8", "0")
	
func _frame_16():
	host.apply_force_relative("-8", "0")
	
func _frame_24():
	host.apply_force_relative("8", "0")
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)

	if obj == host.opponent:
		if "Bleed" in hitbox.misc_data:
			host.bleed += 40
	
func _tick():
	._tick()
	
	if current_tick < 28:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "WallSlam"
		host.opponent.sprite.frame = 100
	
	if current_tick < 24 and (not current_tick in [13, 14, 15, 16]):
		host.global_hitlag(1)
		
	host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)
