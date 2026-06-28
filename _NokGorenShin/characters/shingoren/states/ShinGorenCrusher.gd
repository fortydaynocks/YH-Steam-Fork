extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var force = 6

func is_usable():
	self.super_level_ = 1
	self.supers_used_ = 1
	
	if host.current_state().state_name in ["firewalk"]:
		self.super_level_ = 0
		self.supers_used_ = 0
	
	return .is_usable()

func _frame_7():
	var dir = xy_to_dir(data.x, data.y, str(force))
	var vec = Vector2(dir.x, dir.y).normalized()
	var obj = host.spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/Crusher.tscn"), 32, -24, true, null, true)
	obj.set_grounded(false)
	obj.apply_force(dir.x, dir.y)

func _tick():
	._tick()
	
	if current_tick and current_tick < 6:
		host.global_hitlag(1)
