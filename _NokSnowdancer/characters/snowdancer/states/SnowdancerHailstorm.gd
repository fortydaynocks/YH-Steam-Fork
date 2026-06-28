extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

var initial_dist = 160
var extra_dist = 80

func is_usable():
	var found_hailstorms = 0
	
	for hailstorm in host.objs_map.values():
		if is_instance_valid(hailstorm):
			if hailstorm.creator == host and hailstorm.disabled != true and hailstorm.get("is_snowdancer_proj") == true:
				if hailstorm.get("identity") == "Hailstorm":
					found_hailstorms += 1
	
	return .is_usable() and host.snowflakes.value >= 3 and found_hailstorms < 1
	
func _frame_1():
	host.increment_snowflakes(-1)

func _frame_3():
	if host.is_grounded() == true:
		host.apply_force_relative("0", "-4")

func _frame_10():
	var dist = (float(data.x) / 100) * extra_dist
	
	var obj = host.spawn_object(host.objs_table.Hailstorm, initial_dist + dist, -250, true, null, true)
	obj.set_grounded(false)

func _tick():
	._tick()
	
	if current_tick < 12:
		host.global_hitlag(1)
	
	if current_tick % 2 == 0:
		host.afterimage(Color(0.8, 0.86, 0.99, 1), 0.1)
