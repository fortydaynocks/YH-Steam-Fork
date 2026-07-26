extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var order = preload("res://_NokVenerator/venerator/projectiles/EradicationOrder.tscn")

func _frame_0():
	host.opponent.change_state("Grabbed")
	host.play_sound("EraOrder3")
	
	host.start_invulnerability()

func _frame_17():
	var proj = host.spawn_object(order, 100, -18, true, {"raw": self._previous_state().get("raw")}, true)
	proj.set_grounded(false)
	
	host.play_sound("Shine")
	
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Star3.tscn"),
		Vector2(0, -24)
	)

func _frame_1000():
	host.change_state("eraorder3")	#	--	FAILSAFE

func _tick():
	._tick()
	
	if current_tick <= 10:
		host.apply_force_relative("1", "-2")
		
	if current_tick < 17:
		host.global_hitlag(1)
