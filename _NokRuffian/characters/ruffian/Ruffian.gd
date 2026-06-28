extends Fighter

var player_info = null

var charname = "Ruffian"
var idle = 1
var won = false

var skin = 0
var skin_aura = true
var skin_enabled = true
var magic_series = 0
var magic_drag = 0
var magic = false

var weaving = false
var weave_buffered = false
var attacking = false
var attack_buffered = false
# idk what these do so imma just keep em here
var can_followup = false
var followed_up = false
var in_range = false
var cc = true

var can_play_song = false
onready var bgm = $"%BGM"
var song_dominance = false

onready var duckicon = $StateMachine/exduck

var stop_ticks = 0
var cinestopped = false

# joke mechanic. 69 69 DI in singleplayer
# turns all moves into f1. set DI to -69 -69 to turn it off
var turn_everything_f1 = false
#onready var bgm2 = $"%BGM"

#	---------------------------------------------------------------------------------------------------------------
#	---------------------------------------------------------------------------------------------------------------

#	1:	Mentenner House
#	2:	Essence of Chrysler


var dev_teehee = {
	"Trinity":[76561198979732692],
	"nok":[76561199013223613],
}

var skins = {
	"nok":[76561199013223613],
	"soopernoob":[76561198855083592],
	"samuraiarceus":[76561199609718964],
	"CTM9001":[76561198864502801],
	"Cherry":[76561198084678092],
	"Death":[76561198230319932],
	"Mana":[76561198079821152],
	"MCHurt12":[76561198333601578],
	"Nutay":[76561199086224834],
	"Ceiling":[76561199469230835],
	"Draedon":[76561199116310765],
	"Pres":[76561198159217589],
	"Korbus":[76561198797781143],
	"ThatBox":[76561198134499262],
	"Salty_shy guy":[76561199207543446],
#	"Rere3419":[This user's display name does not exist as of Oct. 20, 2025. Using failsafe],
	"Trinity":[76561198979732692],
	"TriGambit":[76561199251891016],
	"Sleepy_Dorm":[76561199089133062],
#	"Ruffian":[76561198979732692],
	"Thunderlight25":[76561199013428120],
	"The Notorius Rice Stealer":[76561199351072644],
	"JakeLore":[76561198057282235],
	"SmallSlab":[76561198057282235],
	"TheSolarInferno":[76561198243977166],
	"absolutely tutoumi": [76561198035450233],
}

var failsafe_skins = [
	["Rere3419", 1]
]

#	---------------------------------------------------------------------------------------------------------------
#	---------------------------------------------------------------------------------------------------------------

func getOpponentName(): #Returns a string with the opponent name.
	var name = find_parent("Main").match_data.selected_characters[opponent.id]["name"] #Grabs the opponent's name.
#Modified from Bard's code to be multihustle friendly.
#Is the same as it appears in the character select menu.

		#When mods are exported to be built in the main game, their file name changes, so the below code trims it appropriately.
	var filter = name.rfind("__")

	if filter != -1:
		filter += 2
		name = name.right(filter)

	#Skin-based name overrides
	if name == "Example Character" && opponent.has("VariableMarkedOnSpecialSkins") && opponent.VariableMarkedOnSpecialSkins: #This sort of thing will need to be adjusted for on a character-by-character basis.
		name = "Example Character Skin Override" #We can change the name of the character to better adjust to skins, such as Elder's fursuit convention skin.

	#====================================

	return name

func get_steamid(id):
	var player_count = Network.network_ids.size()
	if Network.steam == true and not SteamLobby.SPECTATING and player_count > 1:
		return Network.network_ids[id]
	elif ReplayManager.frames.get("steam_ids"):
		return ReplayManager.frames["steam_ids"][id]
	return 0

func init(pos = null):

	if not ReplayManager.frames.get("steam_ids") and Network.steam == true:
		ReplayManager.frames["steam_ids"] = Network.network_ids

#	MAX_HEALTH = 1400
#	hp = 1400
	.init(pos)

var voice = false
var song = false

func apply_style(style):
	.apply_style(style)
	var chat_window = get_node_or_null("/root/Main/UILayer/ChatWindow")
	skin = 0
	if style != null:
		var user_name = Network.pid_to_username(id)
		if apply_skin() == true:
			voice = style.get("voice", true)
			song = style.get("music", true)
			skin = 1 if (voice == true or song == true) else 0
		else:
			voice = false
			song = false
			skin = 0
# Old Style System. UNUSED.
#			if "Mentenner House" in style.style_name or "JakeLore" in user_name:
#				skin = 1
##				if not "[~]" in style.style_name:
##					chat_window.god_message("You can put [~] in your style name to remove the aura effect.")
#				skin_aura = not "[~]" in style.style_name
##			elif not "Mentenner House" in style.style_name and not "JakeLore" in user_name:
##				chat_window.god_message("Put Mentenner House in your style name to use the Mentenner House bonus!")
#			elif "Essence of Chrysler" in style.style_name:
#				skin = 2
#
##	- this skin system is specifically for those who's Steam IDs are inaccessible
#		if [user_name, 1] in failsafe_skins or [user_name, 2] in failsafe_skins:
#
#			if "Mentenner House" in style.style_name:
#				skin = 1
#
#				if "[~]" in style.style_name: skin_aura = false
#
#			if "Essence of Chrysler" in style.style_name:
#				skin = 2			

#	---------------------------------------------------------------------------------------------------------------
#	---------------------------------------------------------------------------------------------------------------

func apply_skin():
	# Returns as true or false, then use the returned boolean (true/false statement) like you'd use is_grounded()
	var username = Network.pid_to_username(id)
	
	if not Network.multiplayer_active and not SteamLobby.SPECTATING:
		if Global.current_game.match_data.get("singleplayer") == true:
			if skins.has(username) or username == "Ruffian":
				return true
		else:
			if get_steamid(id) in skins[username]:
				return true
	else:
		if Network.multiplayer_active or ((ReplayManager.playback or ReplayManager.replaying_ingame) and Global.current_game.match_data.get("singleplayer") == false):
			if get_steamid(id) in skins[username]:
				return true
	return false

func is_dev():
	# Returns as true or false, then use the returned boolean (true/false statement) like you'd use is_grounded()
	var username = Network.pid_to_username(id)
	
	if not Network.multiplayer_active and not SteamLobby.SPECTATING:
		if Global.current_game.match_data.get("singleplayer") == true:
			if dev_teehee.has(username) or username == "Ruffian":
				return true
		else:
			if get_steamid(id) in dev_teehee[username]:
				return true
	else:
		if Network.multiplayer_active or ((ReplayManager.playback or ReplayManager.replaying_ingame) and Global.current_game.match_data.get("singleplayer") == false):
			if get_steamid(id) in dev_teehee[username]:
				return true
	return false



func super_effect(freeze_ticks = 0):
	.super_effect(freeze_ticks)
	
	if freeze_ticks > 0:
		self.play_sound("SuperSF3")
#		self.spawn_particle_effect_relative(preload("res://_NokRuffian/characters/ruffian/effects/RFSuperFlash.tscn"), Vector2(0, -18))

func trail(type = "EX"):
	var obj
	
	if type == "EX":
		obj = preload("res://_NokRuffian/characters/ruffian/effects/RFTrail_EX.tscn")
	elif type == "SUPER":
		obj = preload("res://_NokRuffian/characters/ruffian/effects/RFTrail_Super.tscn")

	var new_obj = self._spawn_particle_effect(obj, Vector2(float(self.get_pos().x), float(self.get_pos().y) - 18), Vector2(self.get_facing_int(), 0))

	for tx in new_obj.get_children():
		if tx.name == "trail":
			tx.texture = self.sprite.frames.get_frame(self.sprite.animation, self.sprite.frame)
			
#	--	PARRY EFFECT
func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokRuffian/characters/ruffian/effects/parry/RFParry.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

func voiceline(sound, volume):
	
	$"%Voiceline".stream = sound
	$"%Voiceline".volume_db = volume
	if voice == true:
		play_sound("Voiceline")

#	---------------------------------------------------------------------------------------------------------------
#	---------------------------------------------------------------------------------------------------------------

var armored = false
func hit_by(hitbox, force_hit = false):
	
	
	if $"%Voiceline".playing == true and opponent.visible_combo_count <= 1:
		if hitbox.hitlag_ticks >= 12 or hitbox.damage >= 100:	#	--	STRONG MOVE
			if hp <= 0:
				voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00000.wav"), -6)
			else:
				voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00003.wav"), -6)
		else:	#	--	WEAK MOVE
			if hp <= 0:
				voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00001.wav"), -6)
			else:
				voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00002.wav"), -6)

	if armored == true and not hitbox.throw and not hitbox.ignore_armor:
		take_damage(hitbox.damage/2, hitbox.minimum_damage/2)
		var thing = obj_from_name(hitbox.host)
		if is_instance_valid(thing) and thing:
			if thing is Fighter:
				hitlag_ticks = 0
				opponent.hitlag_ticks = 0
				opponent.current_state().enable_interrupt()
				current_state().enable_interrupt()
				opponent.blocked_hitbox_plus_frames += 1
#		state_hit_cancellable = false
#		opponent.state_hit_cancellable = false
#		hitbox.cancellable = false
		return
	.hit_by(hitbox, force_hit)

var hitnum = 0
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	
	if obj == self.opponent and skin == 1 and magic_series == 3 and magic == false and song == true:
		
		magic = true
			
		play_sound("Parry")
		play_sound("SuperSF3")
		play_sound("MeterSF3")
		
		screen_bump(Vector2(0, 0), 4, 0.25)
		spawn_particle_effect_relative(preload("res://_NokRuffian/characters/ruffian/effects/RF_EX.tscn"), Vector2(0, -18))

	if obj is Fighter:
		if hitbox.throw:
			opponent.feinting = false
			opponent.feint_parriable = false
		if turn_everything_f1 == true:
			hitlag_ticks = 0
		if weaving == true and not current_state().name in ["duck", "duck2"] and got_parried == false and not current_state() is CharacterHurtState and current_state().name != "Grabbed" and not current_state() is ThrowState:
			change_state("duck" if combo_count <= 0 else "duck2")
			weaving = false
			hitlag_ticks /= 2
#			opponent.hitlag_ticks += hitbox.hitlag_ticks/2
		if current_state().name in ["exmachinegunblow", "corkscrewblow"]:
			var pushback_limit = {
				me = Utils.int_clamp(combo_count, 1, 4),
				them = Utils.int_clamp(combo_count, 1, 4),
			}
			add_pushback(str(pushback_limit.me))
			opponent.add_pushback(str(pushback_limit.them))


#func _enter():
#	._enter()
	
	
#func Unlock(balls):
#	var codex = get_node_or_null("/root/CharCodexLibrary")
#	if is_instance_valid(codex):
#		# Multiplayer only
#		if Network.multiplayer_active or OS.is_debug_build() or balls == "Coolio":
#			if codex.unlock_achievement(self, balls, false):
#				play_sound("MeterSF3")

func Unlock(ach: String, type: String):

# THERE'S ONLY 3 TYPES OF ACHIEVEMENTS: S, U, M
#	S is for Singleplayer only
#	U is universal, meaning both single and multiplayer can unlock this achievement
#	M is Multiplayer only

	var codex = get_node_or_null("/root/CharCodexLibrary")
	if is_instance_valid(codex):
		if Network.multiplayer_active and type == "M":
			if codex.unlock_achievement(self, ach, false):
				play_sound("MeterSF3")

		elif not Network.multiplayer_active and type == "S":
			if codex.unlock_achievement(self, ach, false):
				play_sound("MeterSF3")

		if type == "U":
			if codex.unlock_achievement(self, ach, false):
				play_sound("MeterSF3")

		if OS.is_debug_build():
			if codex.unlock_achievement(self, ach, false):
				play_sound("MeterSF3")
		
		if ach == "Coolio":
			if codex.unlock_achievement(self, ach, false):
				play_sound("MeterSF3")


func cinematic(ticks, zoom_ticks):
	stop_ticks = zoom_ticks
	cinestopped = true
	global_hitlag(ticks, true)
#	hitlag_ticks += 100
	if !is_ghost:
		spawn_particle_effect_relative(preload("res://_NokRuffian/characters/ruffian/effects/RFSuperFlash.tscn"), Vector2(0, -18))
		get_camera().focused_object = self
		set_camera_zoom(0.60)
		tween_camera_zoom(0.60, 0.55, 0.35, Tween.EASE_IN, Tween.EASE_IN)
		$"%Darken".modulate.a = 0.75
func zoom_check():
	stop_ticks -= 1
	if cinestopped == true and stop_ticks <= 0:
		stop_ticks = 0
		cinestopped = false
		release_camera_focus()
		if !is_ghost:
			set_camera_zoom(1.00)
			tween_camera_zoom(0.95, 1.00, 0.35, Tween.EASE_IN, Tween.EASE_IN)
			$"%Darken".modulate.a = 0.00

var master_tick = 0
func tick():
	.tick()
	EmoteHandler()

	if turn_everything_f1 == true and not Network.multiplayer_active and not SteamLobby.SPECTATING:

		var start_tick = current_state().earliest_hitbox
		while start_tick > 0 and current_state().current_tick < start_tick - 1:
			state_tick()
			current_state().enable_interrupt()
		while current_state().current_tick > start_tick and current_state().current_tick < current_state().anim_length and start_tick > 0:
			state_tick()
			current_state().enable_hit_cancel()

	if game_over:
		if opponent.hp <=0 and hp > 0:
			if getOpponentName() in ["Wonderboy", "PrizeFighter", "Ruffian"]:
				Unlock("Knockout", "M")
			start_invulnerability()

	if weave_buffered == true:
		weaving = true
		weave_buffered = false
		
	if attack_buffered == true:
		attacking = true
		attack_buffered = false

	if current_state() is CharacterHurtState or current_state().name == "Grabbed":
		attacking = false


	zoom_check()
	master_tick += 1

	if current_state().name in ["rollingthunder"] and combo_count > 0:
		if not is_ghost:
			Global.current_game.time += 1

	#	--

	if skin == 1:
		
		#	-- TAUNT LINES
		if current_state().name == "Taunt" and current_state().current_tick == 0:
			var line = randi_range(0, 1)
			if $"%Voiceline".playing == false:
				if line == 0:
					voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00017.wav"), -6)
#				elif line == 1:
#					voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00016.wav"), -6)
				else:
					voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00019.wav"), -6)
		
		#	-- WIN SOUNDS
		
		if (self.game_over == true and won == false and hp > 0 and opponent.hp <= 0):
			won = true
			# base game end tick is 120
			Global.current_game.game_end_tick = Global.current_game.current_tick + 100
			
		if won == true:
			var wabel = get_node("/root/Main/%WinLabel")
			if current_state().name != "victory":
				current_state().fallback_state = "victory"
				Global.current_game.game_end_tick = Global.current_game.current_tick + 1

		#	--
		if current_state().name == "Start":
			if current_state().current_tick == 1:

				voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00018.wav"), -6)
				
				screen_bump(Vector2(0, 0), 4, 0.25)
			if current_state().current_tick == 11 * current_state().ticks_per_frame:
				spawn_particle_effect_relative(preload("res://_NokRuffian/characters/ruffian/effects/RF_EX.tscn"), Vector2(0, -18))
				play_sound("Parry")
				play_sound("SuperSF3")
		#	--
		
		$"%SkinAura".visible = skin_aura and master_tick > 33
		$"%SkinAura".modulate = style_extra_color_1 if style_extra_color_1 else extra_color_1
		$"%SkinAura".self_modulate = style_extra_color_1 if style_extra_color_1 else extra_color_1
		$"%SkinAura2".visible = magic
		$"%SkinAura2".modulate.r = style_extra_color_1.r if style_extra_color_1 else extra_color_1.r
		$"%SkinAura2".modulate.g = style_extra_color_1.g if style_extra_color_1 else extra_color_1.g
		$"%SkinAura2".modulate.b = style_extra_color_1.b if style_extra_color_1 else extra_color_1.b
		$"%SkinAura2".self_modulate.r = style_extra_color_1.r if style_extra_color_1 else extra_color_1.r
		$"%SkinAura2".self_modulate.g = style_extra_color_1.g if style_extra_color_1 else extra_color_1.g
		$"%SkinAura2".self_modulate.b = style_extra_color_1.b if style_extra_color_1 else extra_color_1.b
		
		var sprite = $"Flip/Sprite"
		$"%afterimage".texture = sprite.frames.get_frame(sprite.animation, sprite.frame)
		
		#	--	SONG CONTROLS
		
		if skin == 1 and magic == true:
			if not $"%BGM".playing == true: 
				$"%BGM".playing = true
				Unlock("Gentlemen", "U")
			
			if self.combo_count >= 1 or self.opponent.hp <= 0:
				song_dominance = true
				
				if $"%BGM".pitch_scale < 1:
#					$"%BGM".volume_db += 0.3
					$"%BGM".pitch_scale += 0.05
					$"%SkinAura2".modulate.a += 0.05
					$"%SkinAura2".self_modulate.a += 0.05
			else:
				song_dominance = false
				
				if $"%BGM".pitch_scale > 0.5:
#					$"%BGM".volume_db -= 0.3
					$"%BGM".pitch_scale -= 0.05
					$"%SkinAura2".modulate.a -= 0.05
					$"%SkinAura2".self_modulate.a -= 0.05

	#	--	MECHANICAL STUFF (From Trinity)
#	melee_attack_combo_scaling_applied = false
	if current_state():
		var cs = current_state()
#		for h in get_active_hitboxes():
		if hitlag_ticks <= 0 and blockstun_ticks <= 0 and opponent.combo_count <= 0:
			if attacking == true and in_range == true and cs.name != "corkscrewblow":
				if got_parried == false and cs.current_tick <= cs.earliest_hitbox - 1 and not current_state() is CharacterHurtState and current_state().name != "Grabbed" and not current_state() is ThrowState and cs.current_tick > cs.earliest_hitbox - 2 or cs.name == "chargestepdash" and cs.current_tick >= 7:
					change_state("corkscrewblow")
					attacking = false


			if weaving == true and cs.name != "duck" and cs.name != "duck2":
				if got_parried == false and not current_state() is CharacterHurtState and current_state().name != "Grabbed" and not current_state() is ThrowState and ((cs.name != "partinggift" and cs.current_tick == cs.earliest_hitbox + 3) or (cs.name == "partinggift" and cs.current_tick == 9)):
					change_state("duck" if combo_count <= 0 else "duck2")
					weaving = false

#func on_state_started(state):
#	.on_state_started(state)
func change_state(state_name, state_data = null, enter = true, exit = true):
	.change_state(state_name, state_data, enter, exit)
	if state_name in ["Grabbed", "ThrowTech"]: # I FUCKING HATE IVYSLY RAHHH
		feinting = false

func on_state_ended(state):
	weaving = false
	

func on_state_changed(states_stack):
	.on_state_changed(states_stack)
	armored = false


func mod_vel(vel_mod: String):
	var vec_mod = fixed.vec_mul(get_vel().x, get_vel().y, vel_mod)
	set_vel(vec_mod.x, vec_mod.y)

func mod_vel_specific(vel_mod_x, vel_mod_y):
	check_params(vel_mod_x, vel_mod_y)
	var vec_mod = {
		x = fixed.mul(get_vel().x, vel_mod_x),
		y = fixed.mul(get_vel().y, vel_mod_y)
	}
	set_vel(vec_mod.x, vec_mod.y)

func set_vel_specific(x, y):
	check_params(x, y)
	set_vel(fixed.mul(str(x), str(get_facing_int())), str(y))

func set_vel_relative(x: String, y: String):
	set_vel(fixed.mul(x, str(get_facing_int())), y)

func can_block_cancel():
	if weaving == true:
		return false
		
	return .can_block_cancel()

func copy_to(f):
	.copy_to(f)
	f.weaving = weaving
	f.attack_buffered = attack_buffered

func process_extra(extra):
	.process_extra(extra)
	if extra.has("Weaving"):
		weave_buffered = extra.Weaving
	if extra.has("Followup"):
		attacking = extra.Followup

var tween

func tween_camera_zoom(initial_value, end_value, duration, transition_type, ease_type):
	if is_ghost or ReplayManager.resimulating:
		return
	var game = Global.current_game
	
	emit_signal("zoom_changed")
	if tween:
		tween.kill()
		set_camera_zoom(initial_value)
		
	tween = game.create_tween()
	
	tween.set_parallel(true)
	tween.set_trans(transition_type)
	tween.set_ease(ease_type)
	
	tween.tween_property(game, "camera_zoom", initial_value, 0.0025)
	
	tween.set_ease(ease_type)
	tween.tween_property(game, "camera_zoom", end_value, duration)
	
	yield (tween, "finished")
	if not is_instance_valid(self):
		return
	tween.kill()
	game.update_camera_limits()

func set_camera_zoom(value):
	if is_ghost or ReplayManager.resimulating:
		return
	if tween:
		tween.kill()
	var game = Global.current_game
	game.camera_zoom = value
	emit_signal("zoom_changed")
	game.update_camera_limits()

func set_pos_relative(posx, posy):
	set_pos(posx * get_facing_int(), posy)

var modified_icons = {}
var button_dictionary = {}

# Credit to Lam (InklessBrush) for this code. vv
func change_state_title(state, title):
	var buttons_path= "/root/Main/%P1ActionButtons" if id == 1 else "/root/Main/%P2ActionButtons"
	var action_buttons = get_node(buttons_path)
	for button in action_buttons.buttons:
		if button.state == state:
			button.action_title = title
func change_action_icon(state_name:String, new_icon:String):
	if is_ghost or modified_icons.get(state_name) == new_icon:
		return
	setup_button_dictionary()
	modified_icons[state_name] = new_icon
	button_dictionary[state_name].get_node("%TextureRect").texture = load(new_icon)
	button_dictionary[state_name].custom_texture = true
func setup_button_dictionary():
	if button_dictionary:
		return
	var action_container = get_node("/root/Main/%P" + str(id) + "ActionButtons")
	for button in action_container.buttons:
		button_dictionary[button.action_name] = button
# Credit to Lam (InklessBrush) for this code. ^^

var Emoting = false
var EmoteTimer = 0

func emote(message):
	ReplayManager.emote(message, id, current_tick)
#	if "res://_NokRuffian/characters/ruffian/sprites/MEMES/RuffianGutterTrashWithText.png" in message and "[img=" in message:
#		turn_everything_f1 = true
#		Unlock("ohno", "S")
	$EmoteLabel.clear()
	$EmoteLabel.append_bbcode("[center]" + message)
	$EmoteLabel.visible_characters = 0
	$EmoteLabel.percent_visible = 0
	$EmoteLabel.show()
	$EmoteLabel.modulate.a = 1.0
	Emoting = true
	EmoteTimer = 0

func EmoteHandler():
	if $EmoteLabel.bbcode_text != "":
		Emoting = true
	if Emoting:
		if $EmoteLabel.percent_visible < 1.0:
			if current_tick % 3 == 0:
				$EmoteLabel.visible_characters += randi_range(1, 2)
				play_sound("Dialogue")
		else:
			EmoteTimer += 1
		if EmoteTimer >= 40:
			$EmoteLabel.modulate.a = lerp($EmoteLabel.modulate.a, 0.0, 0.12)
		if EmoteTimer > 90:
			$EmoteLabel.percent_visible = 0.0
			$EmoteLabel.visible_characters = 0
			$EmoteLabel.hide()
			$EmoteLabel.bbcode_text = ""
			Emoting = false
			EmoteTimer = 0
