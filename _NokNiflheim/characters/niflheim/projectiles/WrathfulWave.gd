extends DefaultFireball

export (PackedScene) var smite_scene

func fizzle():
	
	host.spawn_object(smite_scene, 32, 32)
	host.spawn_object(smite_scene, -32, 32)
	host.spawn_object(smite_scene, 32, -32)
	host.spawn_object(smite_scene, -32, -32)
	
	
	.fizzle()
