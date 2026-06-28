extends SuperMove

export (PackedScene) var wrathfulwave
export (PackedScene) var wrathfulwave_d

func _enter():
	host.play_sound("MetalRingQuiet")

func _frame_11():
	host.spawn_object(wrathfulwave, 0, -18, true, null, true)
	host.spawn_object(wrathfulwave_d, 0, -18, true, null, true)
