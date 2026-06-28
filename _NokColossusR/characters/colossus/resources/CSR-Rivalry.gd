extends CharacterState

#	========================================================================== |
#	READ ALL OF THIS BEFORE YOU DO ANYTHING.
#	YES, ALL OF IT.

#	<< ========== RIVALRY INTRO ========== >>
#	- here is my personal alternative to InklessBrush's "Cross Intro". i like it, but i find it much
#	too long for my tastes. and there's the namesake feature i'd like to have in my own version.

#	- this is fairly noob-proofed, but i'm still assuming you'll understand what i've done here. if not,
#	ask someone for help, or reconsider using it.


#			--	USAGE	--
#	- this state should go underneath the "Start" state, but above everything else.
#	- this state should be called "RVL-Rivalry". i will be incredibly surprised if you already have
#	a state with that name.
#	- within the "Start" state, the following code is required:

#		func _frame_0():
#			if host.opponent.state_machine.get_node("RVL-Rivalry"):
#				host.change_state("RVL-Rivalry")
#				host.opponent.change_state("RVL-Rivalry")
#				return

#	- if you already have an intro, just put that at the top, above all other code.
#	- if not, extend the "Start" script and add this somewhere inside.


#			--	SOUNDS	--	
#	- playing sounds goes in this format:
#	- "<sound_name>": <frame>
#	- put that in the "sounds" dictionary.
#	- the sound name has to match an audio object inside the "Sounds" node to work.



#			-- ANIMATIONS --
#	- animation switching goes in this format:
#		- "<anim_name>": [<frame>, <start_from>]

#	- put that in the "animations" dictionary.



#			-- PARTICLES --
# 	- only four particles are used: "spawn", "hit", "taunt", and "rivalry".
#	- replace the filepath (""res://fx/BurstEffect.tscn" is a filepath) with the particle you want to spawn,
#	and change the Vector2() to change the offset.
#	- "rivalry" doesn't the an offset, as it will always try to spawn at the center of the players. so just leave it.



#			-- QUOTES --
#	- character quotes go in this format:
#		- "<opponent_name>: ["<quote>", "<quote>", "<quote>", ...]

#	- if the opponent has the right "charname" variable, then it will randomly play one of those quotes.
#		- ("charname" is a variable nearly all characters have. it represents the character's name)

#	- set "<opponent_name>" to "_" to have quotes for every character that isn't on the list.
#	- change "soundbyte" and "quote_chunk_size" to change the speed and sound of the quote.
#		- like the audio, the soundbyte name has to match to an audio object inside "Sounds"
#	- disable "use_quote" if you don't want any quotes at all.

#	- example:
#		- var quotes = {
#			"Niflheim": ["Nice sword", "Your fire's too hot!"],
#			"Hellsaint": ["Ahh! Scary!", "Are you sure you're not a demon?"],
#			"_": ["Hello!", "Hi"]



#			-- RIVALRY --
#	- trigger a special effect when you go up against specific characters!
#	- add the character's name into the "Rivals" box. 
#	- if that character also has this one's name in the box, the "Rivalry" effect is triggered.



#			-- ADVANCED NOTES --
#	- you can extend this scene just fine. just make sure you supercall everything correctly.

#		- func enter():
#			._enter()	<-- that is a supercall. it does the original version of the function.

#	<< =================================== >>
#	- that's all of the key stuff!
#	- you should know not to keep the brackets. obviously. you'll get an error if you try to keep them. come on now.

#	- nok / @hekkenok
#	- 21 June 2026

#	========================================================================== |
export (int) var _c_rivalry

#	--
export (Dictionary) var sounds = {
	"Intro1": 1,
	"Intro10": 25,
	"ArmorHit": 30,
	"ApproachStab": 30,
	"GraceFortitude": 90,
}

#	--
export (Dictionary) var animations = {
	"impel": [1, 0],
	"cleave": [25, 4],
	"steelbite": [90, 4],
}

#	--
export (Dictionary) var particles = {
	"spawn": [preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(0, -18)],
	"hit": [preload("res://_NokColossusR/characters/colossus/effects/CSR-HitSlash.tscn"), Vector2(20, -18)],
	"taunt": [preload("res://_NokColossusR/characters/colossus/effects/CSR-Star2.tscn"), Vector2(0, -18)],
	"rivalry": [preload("res://_NokColossusR/characters/colossus/effects/CSR-Hit2.tscn"), Vector2(0, 0)],
}

#	--
export (Dictionary) var quotes = {
	"Torment": [
		"You shackle me no longer.",
		"Your exorcism begins.",
		"Brace yourself, Hellsaint.",
	],
	"Colossus": [
		"The only true match.",
	],
	"_": [
		"Step forth.",
		"You challenge me?",
		"Prepare yourself.",
		"Stand ready.",
		"Very well."
	],
}

export (bool) var use_quote = true
export (String) var soundbyte = "Soundbyte"
export (int) var quote_chunk_size = 2

export (String) var rivalry_sound = "TWC2-Fire2"
export (String, MULTILINE) var rivals = """"""

#	--	leave everything below here as is unless you know what you're doing.
#	========================================================================== |
var game_time = 3600
var state_variables = {}

var start_pos = Vector2(0, 0)
var last_lpos = Vector2(0, 0)
var attack_pos = Vector2(0, 0)

var sprite_delay = 0
var quote_segments = []

var rivalry = false

#	========================================================================== |
func set_start_pos():
	var game = Global.current_game
	
	if host.id == 1 and game.match_data.has("char_height"):
		start_pos = Vector2(-game.char_distance, -game.match_data.char_height)
		
	elif host.id == 2 and game.match_data.has("char_height"):
		start_pos = Vector2(game.char_distance, -game.match_data.char_height)

func reset_placement():
	var game = Global.current_game
	
	if host.id == 1 and game.match_data.has("char_height"):
		host.set_pos(str(-game.char_distance), str(-game.match_data.char_height))
		
	elif host.id == 2 and game.match_data.has("char_height"):
		host.set_pos(str(game.char_distance), str(-game.match_data.char_height))

#	--	MODIFIED SPRITE DISPLAY
func update_sprite_frame():	
	if not host.sprite.frames.has_animation(anim_name):
		return 
	if host.sprite.animation != anim_name:
		host.sprite.animation = anim_name
		host.sprite.frame = 0
		
	#	--
	var sprite_tick = ((current_tick - sprite_delay) / ticks_per_frame)

	if loop_animation and absolute_loop:
		sprite_tick = host.current_tick / ticks_per_frame
	elif loop_animation and not refresh_loop:
		if same_as_last_state:
			sprite_tick = (current_tick + exit_tick) / ticks_per_frame
	
	var frame = (sprite_tick % (sprite_anim_length - animation_loop_start) + animation_loop_start) if (loop_animation and sprite_tick > animation_loop_start) else sprite_tick
	host.sprite.frame = frame

func switch_animation(anim, start = 0):
	if not host.sprite.frames.has_animation(anim):
		return 
	
	self.anim_name = anim
	sprite_delay = (self.current_tick - (start * ticks_per_frame)) + 1

func divide_string(string = "", division = quote_chunk_size):
	var words = []
	var length = len(string)
	var r = range(0, length, division)
	
	for i in range(0, length, division):
		words.append(string.substr(i, division))
	
	return words

#	========================================================================== |
func _enter():
	._enter()
	
	sprite_delay = 0
	game_time = Global.current_game.time
	
	$RivalText.visible = false

func _exit():
	._exit()
	
	$RivalText.visible = false
	$RivalWarning.visible = false
	
func _frame_0():
	var opp_rivalry = host.opponent.state_machine.get_node("RVL-Rivalry")
	
	if opp_rivalry:
		rivalry = host.opponent.get("charname") in rivals and host.get("charname") in opp_rivalry.rivals
	
	set_start_pos()
	host.set_pos(str((-start_pos.x * 2) + (200 * host.get_facing_int())), "0")
	
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

	host.modulate.a = 0
	
func _frame_1():
	if rivalry:
		host.play_sound(rivalry_sound)
		host.spawn_particle_effect_relative(particles.rivalry[0], Vector2(-host.get_pos().x, host.get_pos().y - 18))
		
		if host.id == 1:
			$RivalWarning.visible = true

func _frame_30():
	$RivalText.visible = true
	host.modulate.a = 1
	
	if use_quote:
		var string
		
		if host.opponent.get("charname") in quotes: string = host.randi_choice(quotes[host.opponent.charname])
		else: string = host.randi_choice(quotes._)
		
		quote_segments = divide_string(string)

func _tick():
	
	#	--	CODE FROM THE ORIGINAL "INTRO"
	host.penalty = 0
	host.opponent.penalty = 0
	
	var game = Global.current_game
	
	if (game.time - game.current_tick < game_time):
		game.time += 1
		
	if host.opponent.stance != "RivalIntro" and current_tick < anim_length - 1:
		for v in state_variables.keys():
			host.opponent.set(v,state_variables[v])
		host.opponent.hitlag_ticks = 1
		host.opponent.state_interruptable = false
		
	if current_tick == anim_length - 1:
		host.opponent.state_interruptable = true
		host.state_interruptable = true
		host.stance = "Normal"
		return "Wait"
	#._tick()
	
	#if host.id == 1: print(current_tick)
	
	#	--
	var pos = host.get_pos()
	
	#host.reset_momentum()
	host.colliding_with_opponent = false
	
	$RivalWarning.position = Vector2(-pos.x, -18)
	$RivalWarning.scale = lerp($RivalWarning.scale, Vector2(4, 4), 0.1)
	
	#	--
	if current_tick == 0:
		host.apply_force_relative("-4", "0")
		host.update_facing()
		
	if current_tick == 1:
		host.update_facing()
		if particles.has("spawn"): host.spawn_particle_effect_relative(particles.spawn[0], particles.spawn[1])
	
	if current_tick > 15:
		$RivalWarning.modulate.a = lerp($RivalWarning.modulate.a, 0, 0.1)
	
	if current_tick == 30:
		host.set_pos("0", str(pos.y))
		host.move_directly_relative("-40", "0")
		
		last_lpos = Vector2(0, host.get_pos().y)
		
		if host.id == 1:
			host.screen_bump(Vector2(1, 0), 64, 0.25)
		host.rumble(1, 20)
		
	if current_tick == 31:	
		if particles.has("hit"): host.spawn_particle_effect_relative(particles.hit[0], particles.hit[1])
	
	if current_tick > 30 and current_tick <= 90:
		var lpos_x = lerp(last_lpos.x, start_pos.x, 0.05)
		var lpos_y = lerp(last_lpos.y, start_pos.y, 0.05)

		print(start_pos)
		
		last_lpos = Vector2(lpos_x, lpos_y)
		host.set_pos(str(lpos_x), str(lpos_y))
	
	if current_tick == 40:
		if host.id == 1:
			host.screen_bump(Vector2(1, 0), 8, 0.75)
	
	if current_tick == 90:
		host.update_facing()
		
		if particles.has("taunt"): host.spawn_particle_effect_relative(particles.taunt[0], particles.taunt[1])
		if host.id == 1:
			host.screen_bump(Vector2(0, -1), 4, 0.5)
			
	if current_tick >= 90:
		reset_placement()
		
		$RivalText.modulate.a = lerp($RivalText.modulate.a, 0, 0.1)

	#	--	SOUNDS
	for sound in sounds.keys():
		if current_tick == sounds[sound]:
			host.play_sound(sound)
			
	for animation in animations.keys():
		if current_tick == animations[animation][0]:
			switch_animation(animation, animations[animation][1])
			
	#	--	SOUNDBYTE
	if current_tick >= 30 and current_tick % 3 == 0:
		if len(quote_segments) > 0:
			$RivalText.bbcode_text += quote_segments[0]
			host.play_sound(soundbyte)
			quote_segments.pop_front()

	#	--	OTHER THINGS
	if current_tick <= 30:
		host.modulate.a = lerp(host.modulate.a, 1, 0.1)
