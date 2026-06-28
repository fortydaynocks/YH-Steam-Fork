extends DefaultFireball

func _frame_4():
	host.creator.grabbyhands += 1
	host.creator.stress += 0.06

func _tick():
	._tick()
	
	$"%Eyeball".visible = false
	$"%Tracker".visible = false
	
	
