extends DefaultFireball

func _tick():
	._tick()
	
	$"%Eyeball".visible = false
	$"%Tracker".visible = false
