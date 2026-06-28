extends DefaultFireball

func _enter():
	if host.creator:
		host.sprite.rotation = host.creator.sprite.rotation
		host.set_facing(host.creator.get_facing_int())
