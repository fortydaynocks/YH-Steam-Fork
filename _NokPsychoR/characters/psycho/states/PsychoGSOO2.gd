extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var repeats = [0, 3]
onready var hbox = $"%HitboxGSOO2Barrage"

func _frame_0():
	repeats[0] = 0
	host.start_invulnerability()

func _frame_10():
	self.drag = false
	
	if is_instance_valid($"%RedBG") and !host.is_ghost:
		$"%RedBG".visible = true
		$"%RedBG".modulate = Color(0, 0, 0, 1)

func _frame_32():
	host.play_sound("GSOO3")
	host.play_sound("GSOO4")
	
func _frame_40():
	if $"%Stuff".skin == "Aimorrago":
		$"%Stuff".do_text(host.randi_choice($"%Stuff".ai_quotes.GSOO))
	
func _frame_46():
	host.play_sound("GSOO3")
	host.play_sound("GSOO4")

func _frame_60():
	host.play_sound("GSOO3")
	host.play_sound("GSOO4")
	
func _frame_62():
	host.play_sound("GSOO5")
	host.apply_force_relative("8", "0")
	
func _frame_64():
	host.play_sound("GSOO6")
	host.update_facing()

func _frame_65():
	host.play_sound("GSOO7")
	
	var opos = host.opponent.get_pos()
	var ofac = host.opponent.get_facing_int()
	
	host.set_pos(opos.x - (ofac * 30), opos.y)
	host.apply_force_relative("6", "0")
	
	host.afterimage(Color(1, 0, 0, 1), 0.2)
	self.drag = true

func _frame_66():
	host.afterimage(Color(1, 0, 0, 1), 0.2)
	
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("Insanity-AI")
		host.play_sound("Insanity1")

func _frame_68():
	if $"%Stuff".skin == "Aimorrago":
		pass
	
	else:	
		host.play_sound("GSOO8")

func _frame_74():
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("Insanity-AI2")
		host.play_sound("SilentTreatment2")
		host.play_sound("GSOO-AI2")
	
	else:
		host.play_sound("GSOO9")
		host.play_sound("GSOO10")
	
func _frame_78():
	if is_instance_valid($"%RedBG") and !host.is_ghost:
		$"%RedBG".modulate = Color(0.7, 0, 0, 1)
		host.get_node("Flip").modulate = Color(0, 0, 0, 1)
		host.opponent.get_node("Flip").modulate = Color(0, 0, 0, 1)
		Global.current_game.fx_node.modulate = Color(0, 0, 0, 1)
	
func _frame_109():
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("AISound1")
		
	else:
		if not $"%Stuff".skin == "Guillotine": host.play_sound("GSOO11")
		host.play_sound("GSOO12")
	
	host.play_sound("GSOO13")
	
func _frame_108():
	if is_instance_valid($"%RedBG") and !host.is_ghost:
		$"%RedBG".modulate = Color(0, 0, 0, 1)
		host.get_node("Flip").modulate = Color(1, 1, 1, 1)
		host.opponent.get_node("Flip").modulate = Color(1, 1, 1, 1)
		Global.current_game.fx_node.modulate = Color(1, 1, 1, 1)
	
func _frame_116():
	if is_instance_valid($"%RedBG") and !host.is_ghost:
		$"%RedBG".visible = false
		host.get_node("Flip").modulate = Color(1, 1, 1, 1)
		host.opponent.get_node("Flip").modulate = Color(1, 1, 1, 1)
		Global.current_game.fx_node.modulate = Color(1, 1, 1, 1)


func _exit():
	._exit()
	
	if is_instance_valid($"%RedBG") and !host.is_ghost:
		$"%RedBG".visible = false
		host.get_node("Flip").modulate = Color(1, 1, 1, 1)
		host.opponent.get_node("Flip").modulate = Color(1, 1, 1, 1)
		Global.current_game.modulate = Color(1, 1, 1, 1)
		
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("SilentTreament-AI2")

func _tick():
	._tick()
	
	host.opponent.invulnerable = current_tick >= 11 and current_tick < 66
	
	if host.opponent.current_state().state_name in ["HardKnockdown"]:
		host.opponent.current_state().current_tick = 10
	
	if current_tick > 20 and current_tick < 60:
		host.global_hitlag(1)
		host.move_directly_relative("3", "0")
		
		host.update_facing()
		
	if current_tick > 66 and current_tick < 76:
		host.global_hitlag(2)
	
	if current_tick >= 107 and repeats[0] < repeats[1]:
		current_tick = 79
		repeats[0] += 1
	
	if current_tick > 109 and current_tick < 116:
		host.global_hitlag(5)
		
	if is_instance_valid(hbox):
		if host.opponent.hp - 60 <= 0:
			hbox.damage = 0
			hbox.minimum_damage = 0
		else:
			hbox.damage = 6
			hbox.minimum_damage = 6
		
	if $"%Stuff".skin == "Aimorrago":
		if current_tick > 74 and current_tick <= 108 and current_tick % 4 == 0:
			host.play_sound("SilentTreament-AI1")
