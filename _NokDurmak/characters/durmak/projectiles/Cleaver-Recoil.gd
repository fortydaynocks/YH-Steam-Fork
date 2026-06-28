extends DefaultFireball

var force = 6
var height = -10

func _frame_0():
	host.reset_momentum()
	
	var dist = host.get_owner().current_di.x
	
	host.apply_force(str((dist / 100.0) * force), str(height))
	
func _tick():
	._tick()
	
	if current_tick % 6 == 0:
		host.play_sound("Swing")
