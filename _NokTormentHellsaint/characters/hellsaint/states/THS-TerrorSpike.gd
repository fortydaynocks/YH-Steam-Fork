extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var target = null
var force = 14

func is_usable():
	return .is_usable() and host.get_most_threatening_star()

func _frame_0():
	target = host.get_most_threatening_star()
	#	SO THE SAME STAR INITIATED WILL BE THE ONE USED


func _frame_6():
	if target:
		var nData = Vector2(data.x, data.y).normalized()
		if nData == Vector2(0, 0): nData = Vector2(host.get_facing_int(), 0)
		var dir = xy_to_dir(nData.x * 100, nData.y * 100, str(force))
		
		target.spike(dir)

func _frame_9():
	if host.opponent.current_state() is ParryState or host.combo_count > 0:
		self.enable_interrupt()
