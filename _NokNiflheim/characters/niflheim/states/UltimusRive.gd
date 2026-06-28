extends SuperMove

var candrag = true

func _enter():
	apply_pushback = false
	
func _exit():
	candrag = false
	
func _tick():
	if current_tick == 8:
		candrag = true
	else:
		candrag = false
	
	if current_tick <= 20:
		apply_pushback = true
		
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent:
		host.start_burn(host.opponent, 10, 2)
	
	if candrag == true and obj == host.opponent:
		var pos = host.get_pos()
		var dir = host.get_facing_int()
		
		obj.set_pos(pos.x + (dir * 6), pos.y)
