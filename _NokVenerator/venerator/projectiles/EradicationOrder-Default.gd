extends DefaultFireball

onready var hbox = $Hitbox
onready var hbox_end = $HitboxEnd

var converge_speed = 0.06
var damages = [600, 375]
var raw = false

#	FRAMES 60 -> 150 = 90 TICKS OF ACTIVITY

func _frame_0():
	for beam in $"%SmallBeams".get_children(): beam.emitting = true
	host.play_sound("EraCharge")	
	
	raw = data.raw if data.get("raw") else false

func _frame_60():
	for beam in $"%SmallBeams".get_children(): beam.emitting = false
	$"%Beam".start_emitting()
	
	host.set_facing(-host.get_owner().get_facing_int())
	host.play_sound("Era")
	host.play_sound("Era2")
	host.screen_bump(Vector2(0, 0), 16, 0.1)
	
	host.get_opponent().modulate.r = 0
	host.get_opponent().modulate.g = 0
	host.get_opponent().modulate.b = 0

func _frame_62():
	host.stop_sound("EraCharge")

func _frame_150():
	$"%Beam".stop_emitting()
	
	host.play_sound("EraEnd")
	host.play_sound("EraEnd2")
	host.screen_bump(Vector2(0, 0), 4, 0.1)
	
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Star3.tscn"),
		Vector2(0, 0)
	)
	
	host.get_owner().change_state("eraorder3")
	host.get_opponent().modulate = Color(1, 1, 1)
	
	if host.get_opponent().hp <= 1:
		host.get_opponent().hp = 0
		host.get_opponent().change_state("Grabbed")
		host.get_opponent().modulate = Color(1, 1, 1, 0)
		
	else:
		if is_instance_valid(hbox_end):
			host.get_opponent().launched_by(hbox_end.to_data())
		
	#	--
	host.disable()

func _exit():
	._exit()
	
	host.get_opponent().modulate = Color(1, 1, 1)

func _tick():
	._tick()
	
	var opos = host.get_opponent().get_pos()
	host.set_pos(str(opos.x), str(opos.y - 18))
	
	if current_tick < 60:
		$"%ChargeBeamC".position = lerp($"%ChargeBeamC".position, Vector2(0, 0), converge_speed)
		$"%ChargeBeamL1".position = lerp($"%ChargeBeamL1".position, Vector2(0, 0), converge_speed)
		$"%ChargeBeamR1".position = lerp($"%ChargeBeamR1".position, Vector2(0, 0), converge_speed)
		$"%ChargeBeamL2".position = lerp($"%ChargeBeamL2".position, Vector2(0, 0), converge_speed)
		$"%ChargeBeamR2".position = lerp($"%ChargeBeamR2".position, Vector2(0, 0), converge_speed)

	if current_tick >= 60 and current_tick < 150:
		host.screen_bump(Vector2(0, 0), 2, 0.1)
		
		if raw:
			if host.get_opponent().hp - damages[0] / 90 <= 0:
				host.get_opponent().hp = 1
			else:
				host.get_opponent().take_damage(damages[0] / 90, damages[0] / 90)
		else:
			if host.get_opponent().hp - damages[1] / 90 <= 0:
				host.get_opponent().hp = 1
			else:
				host.get_opponent().take_damage(damages[1] / 90, damages[1] / 90)
			
		if is_instance_valid(hbox):
			host.get_opponent().launched_by(hbox.to_data())
