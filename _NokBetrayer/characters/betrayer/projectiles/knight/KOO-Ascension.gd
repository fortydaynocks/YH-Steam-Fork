extends "res://_NokBetrayer/characters/betrayer/projectiles/knight/KOO-State.gd"

func _exit():
	._exit()
	
	$"%Wings".visible = true

func _frame_0():
	$"%Wings".visible = false
	
func _frame_31():
	$"%Wings".visible = true

func _frame_42():
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()
	
	host.set_facing(-1 if pos.x > opos.x else 1)

func _tick():
	._tick()
	
	if current_tick in [57, 58, 59, 60]:
		host.global_hitlag(1)
	
	if current_tick <= 12:
		if current_tick % 3 == 0 and host.creator.skin == "Munanyou":
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/skins/munanyou/effects/BT-MU-LightningCharge.tscn"), Vector2(0, -18))
			host.screen_bump(Vector2(0, 0), 1, 0.05)
