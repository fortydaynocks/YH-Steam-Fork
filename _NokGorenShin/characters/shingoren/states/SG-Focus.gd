extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func is_usable():
	return .is_usable()

func _frame_0():
	if self.supers_used_ < 5:
		self.super_level_ += 1
		self.supers_used_ += 1

func _frame_1():
	host.firewalk.Value += 1
	host.firewalk.Max += 1
	
func _tick():
	._tick()
	
	if current_tick % 6 == 1:
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(1, 0))
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(-1, 0))
