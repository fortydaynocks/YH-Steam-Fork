extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var dist = 5
var fall = 15

func _frame_6():
	host.reset_momentum()
	
	var dir = (float(data.x) / 100) * dist
	host.apply_force_relative(str(dist), str(fall))
	host.apply_force(str(dir), "0")

func _tick():
	._tick()

	if current_tick >= 7 and current_tick < 15:
		var vel = Vector2(host.get_vel().x, host.get_vel().y)
		
		if current_tick % 2 == 0:
			host.afterimage(Color("#5300ff"), 0.05)
			host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(0, -18), vel.normalized())
