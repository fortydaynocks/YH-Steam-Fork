extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

#var push_force = 4

func is_usable():
	self.super_level_ = clamp(host.firewalk.Max, 0, 3)
	self.supers_used_ = clamp(self.super_level_ - 1, 1, INF)
	return .is_usable()

func _frame_1():
	host.firewalk.Value += 1
	host.firewalk.Max += 1
	
func _tick():
	._tick()
	
	if current_tick % 6 == 1:
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(1, 0))
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(-1, 0))
