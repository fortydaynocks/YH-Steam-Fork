extends DefaultFireball

export (PackedScene) var plume_scene

func fizzle():
	
	host.spawn_object(plume_scene, 48, 16)
	host.spawn_object(plume_scene, 0, 16)
	host.spawn_object(plume_scene, -48, 16)
	
	
	.fizzle()
