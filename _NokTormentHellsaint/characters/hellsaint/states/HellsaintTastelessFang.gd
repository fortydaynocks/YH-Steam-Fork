extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var speed = 18

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost1")

func _frame_6():
	if host.buffers.get("targeted_array"):
		var array = host.obj_from_name(host.buffers.get("targeted_array"))
		
		if array:
			host.set_pos(array.get_pos().x, array.get_pos().y)
			array.disable()
			
			host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Teleport.tscn"), Vector2(0, -18))
		else:
			host.change_state("Landing")

func _frame_7():
	host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Teleport.tscn"), Vector2(0, -18))

func _frame_12():
	host.reset_momentum()
	
	host.apply_force_relative("4", "0")
	if not host.is_grounded(): host.apply_force_relative("0", "-3")

func _tick():
	._tick()
	
	if current_tick in [7, 8, 9, 10, 11]:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(float(opos.x) - float(pos.x), float(opos.y) - float(pos.y)).normalized()
	
		host.move_directly(str(vec.x * speed), "0")
		host.update_facing()

