extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _frame_1():
	host.apply_force_relative("-8", "0")
	
	host.play_sound("SilentTreatment")
	
func _frame_13():
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit1.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoSilentTreatment.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	
	host.screen_bump(Vector2(0, 0), 4, 0.2)
	
	host.play_sound("SilentTreatment2")
	host.play_sound("SilentTreatment3")
	
	host.afterimage(Color(1, 0, 0, 1), 0.1)
	
func _frame_14():
	host.apply_force_relative("8", "0")
	
func _frame_15():
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar1.tscn"), Vector2(0, -18))
	
func _tick():
	._tick()
	
	if current_tick in [8, 9, 10, 11, 12]:
		host.global_hitlag(1)
	
	if current_tick in [13, 14]:
		host.move_directly_relative("110", "0")
