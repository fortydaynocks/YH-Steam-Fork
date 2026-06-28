extends ThrowState

export (PackedScene) var tp
var starterpos = null

func _enter():
	._enter()
	
	host.start_invulnerability()
	starterpos = host.opponent.get_pos()
	host.exhausted_moves = []

func _exit():
	._exit()
	
	starterpos = null

func _frame_1():
	var opos = host.opponent.get_pos()
	host.spawn_particle_effect(particle_scene, Vector2(float(opos.x), float(opos.y)))

func _frame_7():
	host.reset_momentum()
	host.spawn_particle_effect_relative(tp, Vector2(0, -18))
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
	var offset = Vector2(-24, 0)
	
	host.set_pos(str((float(opos.x) + (offset.x * host.get_facing_int()))), str(float(opos.y) + offset.y))
	host.set_vel(ovel.x, ovel.y)
	
	host.apply_force_relative("4", "0")

func _frame_12():
	host.hitlag_ticks = 4
	host.opponent.hitlag_ticks = 4
	host.opponent.take_damage(80, 26, "1.0")
	
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Laugh4")
		
		$"%Stuff".do_text($"%Stuff".choose_text("KingsRegiment", $"%Stuff".quotes_cml))
		
	else:
		$"%Stuff".do_text($"%Stuff".choose_text("KingsRegiment", $"%Stuff".quotes_tor))

func _frame_42():
	self.apply_grav = true

	if $"%Stuff".skin == "Camila":
		host.play_sound("tastelessfanghit")

func _tick():
	._tick()
	
	if (current_tick > 12 and current_tick <= 30) or current_tick > 42:
		host.global_hitlag(1)

	if current_tick in [26, 30, 34, 38]:
		if (not $"%Stuff".skin == "Camila") or current_tick == 26:
			host.play_sound("comehere2_spin")

func _tick_after():
	._tick_after()

	if current_tick < 12 and starterpos != null:
		host.opponent.set_pos(starterpos.x, starterpos.y)
