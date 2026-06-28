extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_4():
	if host.buffers.get("targeted_array"):
		var array = host.obj_from_name(host.buffers.get("targeted_array"))
		
		if array:
			array.spire()

func _frame_9():
	if host.opponent.current_state() is ParryState or host.combo_count > 0:
		self.enable_interrupt()
