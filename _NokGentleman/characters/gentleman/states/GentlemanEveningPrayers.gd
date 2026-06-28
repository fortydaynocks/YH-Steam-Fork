extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_1():
	host.play_sound("EveningPrayers4")

func _frame_4():
	host.apply_force_relative("-6", "0")
	
func _frame_6():
	host.play_sound("EveningPrayers1")
	
func _frame_10():
	host.apply_force_relative("6", "0")
	host.afterimage(host.colors_table.MainColor, 0.2)
	
	host.start_projectile_invulnerability()
	host.set_pos(str(host.get_pos().x), "0")

func _frame_18():
	host.play_sound("EveningPrayers2")
	
	host.end_projectile_invulnerability()
	
func _frame_26():
	host.play_sound("EveningPrayers3")

func _frame_28():
	host.apply_force_relative("6", "0")

func _tick():
	._tick()
		
	if current_tick in [11, 12, 13, 14, 15, 16]:
		if data == true:
			host.move_directly_relative("10", "0")
			
		else:
			host.move_directly_relative("40", "0")
			
		host.afterimage(host.colors_table.MainColor, 0.25)
		
		if current_tick % 2 == 0:
			host.spawn_particle_effect_relative(host.vfx_table.Dash, Vector2(0, -18), Vector2(host.get_facing_int(), 0))
	
	if current_tick >= 5 and current_tick <= 24:
		host.opponent.turn_frames -= 1
		host.opponent.hitlag_ticks = 1

	if current_tick in [18, 19, 20, 21, 22, 23, 24, 25, 26]:
		host.global_hitlag(1)
