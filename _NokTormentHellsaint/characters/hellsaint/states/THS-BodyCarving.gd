extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func on_got_blocked_by(who):
	if who == host.opponent:
		self.force_drag = true

#	--
func _frame_0():
	self.force_drag = false

func _frame_8():
	host.apply_force_relative("4", "0")
	host.move_directly_relative("10", "0")
	
	if host.buffers.get("targeted_array"):
		var array = host.obj_from_name(host.buffers.get("targeted_array"))
		
		if array:
			host.set_pos(array.get_pos().x, array.get_pos().y)
			array.disable()
			
			host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Teleport.tscn"), Vector2(0, -18))
		else:
			host.change_state("Landing")

func _frame_9():
	host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Teleport.tscn"), Vector2(0, -18))

func _frame_14():
	host.apply_force_relative("4", "0")
	host.move_directly_relative("10", "0")

func _frame_22():
	host.apply_force_relative("4", "0")
	host.move_directly_relative("10", "0")
	
	host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(), Vector2(host.get_facing_int(), 0))
