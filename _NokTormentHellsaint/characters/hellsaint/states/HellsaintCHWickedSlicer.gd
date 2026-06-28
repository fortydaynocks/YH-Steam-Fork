extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

export (PackedScene) var tp

func is_usable():
	return .is_usable() and not self.name in host.exhausted_moves

func _enter():
	._enter()
	
	host.exhausted_moves.append(self.name)

func _frame_1():
	host.play_sound("comeheres_teleport")
	
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost3")

func _frame_7():
	if host.opponent.current_state().state_name in ["Burst", "OffensiveBurst", "DefensiveBurst"]:
		host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Hit1.tscn"), Vector2(0, -18))
		host.change_state("ThrowTech")
	
	host.reset_momentum()
	host.spawn_particle_effect_relative(tp, Vector2(0, -18))
	
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
	var offset = Vector2(-16, 16)
	
	host.set_pos(str((float(opos.x) + (offset.x * host.get_facing_int()))), str(float(opos.y) + offset.y))
	host.set_vel(ovel.x, ovel.y)
	
	host.apply_force_relative("-6", "-6")
	
func _frame_8():
	host.spawn_particle_effect_relative(tp, Vector2(0, -18))
	
func _frame_30():
	host.reset_momentum()
	host.apply_force_relative("-4", "-6")
