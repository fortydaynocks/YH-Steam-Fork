extends CharacterState

var tpf = 0

var game_time = 3600
var state_variables = {}
var roundstartpos
var ogpos = {
	x = 0,
	y = 0,
}

func _enter():
	game_time = Global.current_game.time
	Global.current_game.max_char_distance = 6000

func _frame_0():
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)
	ogpos = host.get_pos()
func _frame_1():
	host.move_directly_relative(-250, 0)

func _tick():
	tpf = ticks_per_frame
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
		game.max_char_distance = 600
		host.stance = "Normal"
		return "Wait"

	if current_tick >= 9 * tpf and current_tick <= 11 * tpf:
		host.move_directly_relative(abs(host.get_pos().x - ogpos.x)/3, 0)
	if current_tick == 11 * tpf:
#		host.play_sound("Explosion")
		host.play_sound("Coolsound")
		host.play_sound("Whiff4")
		host.screen_bump(Vector2(), 0.5, 0.2)
	if current_tick == 12 * tpf:
		host.move_directly_relative(abs(host.get_pos().x - ogpos.x), 0)
	if current_tick == 18 * tpf:
		host.play_sound("Whiff1")
	if current_tick == 22 * tpf:
		host.play_sound("Whiff1")
	if current_tick == 26 * tpf:
		host.play_sound("Whiff2")
	if current_tick == 30 * tpf:
		host.play_sound("Whiff3")
