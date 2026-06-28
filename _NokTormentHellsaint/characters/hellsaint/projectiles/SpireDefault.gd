extends DefaultFireball

var maximum = 20

func _enter():
	._enter()

func _frame_7():
	var mov = clamp(host.get_opponent().get_pos().x - host.get_pos().x, -maximum, maximum)
	host.move_directly(str(mov), "0")

	host.set_facing(1 if host.get_pos().x < host.get_opponent().get_pos().x else -1)
