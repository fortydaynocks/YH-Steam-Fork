extends DefaultFireball

func _enter():
	._enter()
	
	anim_name = "spike" + str(host.randi_range(1, 4))

func _frame_1():
	host.set_pos(str(host.get_pos().x), "0")
