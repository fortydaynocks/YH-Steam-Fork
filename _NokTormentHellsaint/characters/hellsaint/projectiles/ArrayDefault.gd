extends ObjectState

func _tick():
	._tick()
	
	var pos = host.get_pos()
	host.set_pos(str(pos.x), "0")
