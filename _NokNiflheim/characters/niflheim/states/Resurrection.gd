extends CharacterState

export (PackedScene) var resurrection_smite_scene
	
func _frame_8():
	host.reset_momentum()
	
	var dir = xy_to_dir(data.x, data.y, "16")
	host.apply_force(dir.x, dir.y)
	
func _frame_12():
	host.spawn_object(resurrection_smite_scene, 0, -16)
	
func _frame_14():
	host.spawn_object(resurrection_smite_scene, 0, -16)

func _frame_16():
	host.spawn_object(resurrection_smite_scene, 0, -16)
	
func _frame_18():
	host.spawn_object(resurrection_smite_scene, 0, -16)

func _frame_20():
	host.spawn_object(resurrection_smite_scene, 0, -16)
	
func _exit():
	host.update_facing()
