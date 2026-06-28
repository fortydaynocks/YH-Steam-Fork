extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_1():
	host.play_sound("void05")
	host.play_sound("heartbeat")
	
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost2")
	
	host.reset_momentum()
	
	host.start_invulnerability()

func _frame_10():
	host.end_invulnerability()
	
func _frame_4():
	if host.opponent.current_state().state_name in ["Burst", "OffensiveBurst", "DefensiveBurst"]:
		host.change_state("comehere_kingsregiment2")
	
func _tick():
	._tick()
	
	if current_tick >= 18:
		host.apply_grav()
