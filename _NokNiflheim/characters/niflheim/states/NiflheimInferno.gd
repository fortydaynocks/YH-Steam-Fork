extends CharacterState

export(PackedScene) var plume

func _frame_4():
	host.has_hyper_armor = true

func _frame_12():
	host.has_hyper_armor = false

func _frame_14():
	
	host.spawn_object(plume, 64, 0, true, null, true)
	host.spawn_object(plume, 108, 0, true, null, true)
