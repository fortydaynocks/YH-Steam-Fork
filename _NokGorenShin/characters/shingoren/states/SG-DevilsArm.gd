extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var chase_speed = 0.25
var dash_speed = 45

func on_got_blocked():
	.on_got_blocked()
	
	host.play_sound("DevilsArmBlocked")
	host.play_sound("DevilsArmBlocked2")
	
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit1k.tscn"), Vector2(18, -18))

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	#if obj == host.opponent:
		#if host.is_grounded() == true:
			#host.change_state("devilsarm2")

func _frame_13():
	host.play_sound("DevilsArmSwing")

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if current_tick < 19:
		if opos.x > pos.x:
			host.apply_force(str(chase_speed), "0")
			
		else:
			host.apply_force(str(-chase_speed), "0")
	
	if current_tick in [17, 18, 19, 20]:
		if (opos.x - pos.x) * host.get_facing_int() > 30:
			host.move_directly_relative(str(dash_speed), "0")
			
			if host.is_grounded() == true:
				host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
