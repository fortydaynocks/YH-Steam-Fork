extends DefaultFireball

func _tick():
	._tick()
	
	host.set_pos(str(host.creator.opponent.get_pos().x), str(float(host.creator.opponent.get_pos().y) - 18))
