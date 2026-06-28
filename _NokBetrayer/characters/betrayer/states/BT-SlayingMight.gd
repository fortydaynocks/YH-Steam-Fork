extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var dist = 8

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		host.apply_force_relative("0", "-4")

func _frame_1():
	var dir = (float(data.x) / 100) * dist
	host.apply_force_relative("2", "-7")
	host.apply_force_relative(str(dist), "0")
	host.apply_force(str(dir), "0")

func _tick():
	._tick()

	host.afterimage(Color("#006aff"), 0.1)
