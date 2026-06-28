extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

		
func _frame_2():
	var dist = (data.x / 100) * 6
	
	host.apply_force(str(dist), "0")

func _frame_8():
	host.reset_momentum()

func _tick():
	._tick()
	
	if current_tick % 2 == 0 and current_tick > 9:
		host.create_speed_after_image(Color(0.14, 0.14, 0.14, 0.2), 0.05)

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		current_tick = 13
		
		var vel = host.get_vel()
		host.set_vel(str(-float(vel.x) * 0.1), vel.y)
