extends DefaultFireball

func _enter():
	host.sprite.hide()
	
	
func _exit():
	host.disable()
