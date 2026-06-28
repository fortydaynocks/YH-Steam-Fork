extends CharacterState

var game_time = 3600
var state_variables = {}
export (PackedScene) var spike

func _enter():
	game_time = Global.current_game.time
	
func _exit():
	._exit()

func _frame_0():
	if host.opponent.state_machine.get_node("RVL-Rivalry"):
		host.change_state("RVL-Rivalry")
		host.opponent.change_state("RVL-Rivalry")
		return
	
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)
		
	host.start_invulnerability()

func _tick():
	host.penalty = 0
	host.opponent.penalty = 0
	var game = Global.current_game
	if(game.time-game.current_tick<game_time):
		game.time+=1
	if host.opponent.stance != "Intro" and current_tick < 119:
		for v in state_variables.keys():
			host.opponent.set(v,state_variables[v])
		host.opponent.hitlag_ticks = 1
		host.opponent.state_interruptable = false
	if current_tick == 119:
		host.opponent.state_interruptable = true
		host.state_interruptable = true
		host.stance = "Normal"
		return "Wait"
		
	#	--
	
	if $"%Stuff".skin == "Camila":
		if current_tick == 1:
			host.play_sound("heartbeat")
			host.play_sound("Super3")
			
			if not host.opponent.get("charname") in ["Silo", "Aimorrago"]:
				host.play_sound("CA_Laugh2")
				
			$"%Stuff".do_text($"%Stuff".choose_text("Intro", $"%Stuff".quotes_cml))
			
		if current_tick == 38:
			host.play_sound("CA_Intro1")
			
		if current_tick == 42:
			host.play_sound("void05")
			host.play_sound("rootgrow")
			
		if current_tick == 56:
			host.play_sound("CA_Intro3")
			host.play_sound("CA_Intro4")
			host.play_sound("CA_Ghost3")
			host.screen_bump(Vector2(0, 0), 12, 0.25)
			
		if current_tick == 60:
			host.play_sound("heartbeat")
			
		if current_tick == 80:
			host.play_sound("CA_Intro2")
			
	else:
		if current_tick == 1:
			host.play_sound("heartbeat")
			host.play_sound("rootgrow")
			
			host.play_sound("Super3")
			
			$"%Stuff".do_text($"%Stuff".choose_text("Intro", $"%Stuff".quotes_tor))
			
		if current_tick == 44:
			host.play_sound("introswing")
		
		if current_tick == 56:
			host.play_sound("dive")
			host.play_sound("bigslam")
			host.screen_bump(Vector2(0, 0), 16, 0.25)
			
			host.spawn_object(spike, 18, 0, true, null, true)
			host.spawn_object(spike, -18, 0, true, null, true)
		
		if current_tick == 60:
			host.spawn_object(spike, 36, 0, true, null, true)
			host.spawn_object(spike, -36, 0, true, null, true)
			
		if current_tick == 64:
			host.spawn_object(spike, 54, 0, true, null, true)
			host.spawn_object(spike, -54, 0, true, null, true)
			
		if current_tick == 68:
			host.spawn_object(spike, 72, 0, true, null, true)
			host.spawn_object(spike, -72, 0, true, null, true)
			
		if current_tick == 72:
			host.spawn_object(spike, 90, 0, true, null, true)
			host.spawn_object(spike, -90, 0, true, null, true)
		
	#	--
		
