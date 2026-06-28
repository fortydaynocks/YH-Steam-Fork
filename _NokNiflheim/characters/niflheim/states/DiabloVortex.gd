extends SuperMove

var candrag = true

func _enter():
	candrag = true
	
	var dir = xy_to_dir(data.x, data.y, "12")
	host.apply_force(dir.x, dir.y)
	host.apply_forces_no_limit()
	
	host.play_sound("MetalRingQuiet")
	
func _exit():
	candrag = false

func _frame_9():
	print(data.x, data.y)


func _on_hit_something(obj, hitbox):
	
	if obj == host.opponent:
		host.start_burn(host.opponent, 10, 2)
	
	if candrag == true and obj == host.opponent:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		
		var currentvel = host.get_vel()
		host.opponent.set_vel(currentvel.x, currentvel.y)
		host.apply_forces_no_limit()
