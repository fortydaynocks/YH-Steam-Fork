extends SuperMove

var moveenabled = false

func _enter():
	moveenabled = true
	
func _exit():
	moveenabled = false
	
func _on_hit_something(obj, hitbox):
	if obj == host.opponent:
		host.play_sound("MetalRingLoud")
		host.change_state("efchit")
		""
	

func _frame_14():
	host.update_facing()
	var opos = host.opponent.get_pos()
	host.set_pos(opos.x + (host.get_facing_int() * 80), opos.y)
	
#	--

func _tick():
	""
