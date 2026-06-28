extends DefaultFireball

export (PackedScene) var plume_scene

#	--

func _enter():
	host.creator.currentplume = host

func _frame_0():
	host.spawn_object(plume_scene, 0, 16)
	
func _frame_8():
	host.spawn_object(plume_scene, 0, 16)

func _frame_16():
	host.spawn_object(plume_scene, 0, 16)
	
func _frame_24():
	host.spawn_object(plume_scene, 0, 16)
	
func _frame_32():
	host.spawn_object(plume_scene, 0, 16)
	
func _frame_40():
	host.spawn_object(plume_scene, 0, 16)
	
func _frame_48():
	host.spawn_object(plume_scene, 0, 16)

func _frame_56():
	host.spawn_object(plume_scene, 0, 16)
	
func _frame_64():
	host.spawn_object(plume_scene, 0, 16)
	
func _frame_72():
	host.spawn_object(plume_scene, 0, 16)

