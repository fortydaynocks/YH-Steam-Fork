extends Node

#	-----------------------------------------------------------------------------------------------
var tweens = {
	"emote_tween": create_tween(),
}
var colors = {}

var host
var skin_enabled = true
var skin = null
var music_access = false
var DORM = false

var hurt = false
var won = false
var won2 = false
var death_quoted = false

var soundcodes = {
	queue = [],
	groups = [1, 1],
}

var skins = {
	"Akuma": "Mandate", # previously "Essence of Akuma"
	"UberOni": "Uber",
}

#	============================================================================================== >
func render_title(titles: Array, username = ""):
	if not titles: return
	
	if host.is_ghost == false:
		var title_text = "[center]"
		
		for found_title in titles:
			if found_title and found_title != "":
				if title_text != "[center]":
					title_text += " [" + found_title + "]\n"
				else:
					title_text += "[" + found_title + "]\n"
		
		title_text += username
		
		$"%Title".bbcode_text = title_text
		$"%Title".modulate = Color(1, 1, 1, 0.5)
		
		if tweens.has("Title"): tweens.Title.kill()
		else: tweens.Title = null
			
		tweens.Title = create_tween()
		tweens.Title.tween_property($"%Title", "modulate", Color(1, 1, 1, 0), 2)

func do_title(text, username = ""):
	if host.is_ghost == false:
		text += "\n" + username
		
		$"%Title".bbcode_text = text
		$"%Title".modulate = Color(1, 1, 1, 0.5)
		
		if tweens.has("Title"): tweens.Title.kill()
		else: tweens.Title = null
			
		tweens.Title = create_tween()
		tweens.Title.tween_property($"%Title", "modulate", Color(1, 1, 1, 0), 2)

func do_voiceline(sound):
	var chosen_sound = host.randi_choice(sound.audio)
	
	if chosen_sound != null:
		$"%Voiceline".volume_db = sound.volume
		$"%Voiceline".pitch_scale_ = float(sound.pitch)
		$"%Voiceline".pitch_variation = sound.variation
		$"%Voiceline".stream = chosen_sound
		
		host.play_sound("Voiceline")
		
func akuma_modulation(obj):
	if obj.get("modulate"):
		if obj.modulate.is_equal_approx(Color("e64539")) or obj.modulate.is_equal_approx(Color("ff0044")):
			obj.modulate = Color("ff8f8f")
		
		if obj.modulate.is_equal_approx(Color("d10753")) or obj.modulate.is_equal_approx(Color("cc2f7b")):
			obj.modulate = Color("ff0000")
		
		if obj.modulate.is_equal_approx(Color("9f07d0")):
			obj.modulate = Color("8f0000")
		
func uber_modulation(obj):
	if obj.get("modulate"):
		if obj.modulate.is_equal_approx(Color("e64539")) or obj.modulate.is_equal_approx(Color("ff0044")):	
			obj.modulate = Color("ffffff")
		
		if obj.modulate.is_equal_approx(Color("d10753")) or obj.modulate.is_equal_approx(Color("cc2f7b")):
			obj.modulate = Color("8f8f8f")
		
		if obj.modulate.is_equal_approx(Color("9f07d0")):
			obj.modulate = Color("2f2f2f")
	
func recursive_style_modulation(obj):
	if skin == "Akuma":
		if obj.get("modulate"):
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_purple_flame_1")):
				obj.modulate = Color("ff0000").lightened(0.4)
			
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_orange_flame_1")):
				obj.modulate = Color("ff0000").lightened(0.3)
				
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_purple_flame_2")):
				obj.modulate = Color("ff0000").lightened(0.2)
				
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_orange_flame_2")):
				obj.modulate = Color("ff0000").lightened(0.1)
				
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_red_death")):
				obj.modulate = Color("ff0000")
				
		for child in obj.get_children():
			recursive_style_modulation(child)
	
func akuma_voiceline(possible_array, volume = 3):
	if len(possible_array) < 1: return
	
	var choice = host.randi_choice(possible_array)
	if choice:
		host.stop_sound("Voiceline")
		$"%Voiceline".stream = choice
		$"%Voiceline".volume_db = volume
		host.play_sound("Voiceline")
		
func replace_audio(obj, initial, new):
	if initial and new:
		for child in obj.get_children():
			if child.get("stream"):
				if child.stream.resource_path == initial:
					child.stream = load(new)
				
			replace_audio(child, initial, new)
		
func prepare_replace_audio(obj):
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/punch_weak.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hitW.wav")
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/punch_weak2.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hitW.wav")
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/punch_mid.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hitM.wav")
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/punch_strong.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hitS.wav")

	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/goren_punch.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hitW-bass.wav")
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/goren_punch_medium.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hitM-bass.wav")
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/goren_punch_strong.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hitS-bass.wav")
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/goren_punch_bass1.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-hit-bass2.wav")
	
	replace_audio(obj, "res://_NokGorenShin/characters/shingoren/sounds/ashurasenku.wav", "res://_NokGorenShin/characters/shingoren/skins/akuma/sounds/ak-ashura.wav")

func soundcodes_process():
	var state = host.current_state()
	
	if state:
		var state_tick = state.current_tick
	
		if state_tick == 0:
			
			#	--	RESETTING
			soundcodes.queue = []
			soundcodes.group = [1, 1]
			
			var codes = Utils.split_lines(state.editor_description)
			
			for code in codes:
				var split_code = code.split("=")
				if len(split_code) == 4:
					soundcodes.queue.append(split_code)
					
					if int(split_code[1]) > soundcodes.group[1]:
						soundcodes.group[1] = int(split_code[1])
						
					soundcodes.group[0] = host.randi_range(1, soundcodes.group[1])
		else:
			
			#	--	PROCESSING
			for soundcode in soundcodes.queue:
				if (soundcode[0] == "dormVL" and DORM):
					if soundcodes.group[0] == int(soundcode[1]) and state_tick == int(soundcode[2]):
						soundcode_voiceline(soundcode[3], "DORM")
			
func soundcode_voiceline(file_name = null, type = null):
	if file_name and file_name == "<none>": return
	host.stop_sound("SC-Voiceline")
	if not file_name: return
	
	if type == "DORM":
		$"%SC-Voiceline".stream = load("res://_NokGorenShin/characters/shingoren/skins/dorm/voicelines/%s.wav" % file_name)
	host.play_sound("SC-Voiceline")

#	============================================================================================== >
func unlock_achievement(ach, allow_offline = false, relock_after = false):
	if host.is_ghost: return
		
	var codex = get_node_or_null("/root/CharCodexLibrary")
	
	if is_instance_valid(codex):
		if Network.multiplayer_active or allow_offline == true:
			codex.unlock_achievement(host, ach)
		
			if relock_after == true:
				codex.relock_achievement(host, ach)
#	============================================================================================== >
func thing_happened(thing, pam1 = null, pam2 = null):
	if thing == "parried":
		if DORM:
			soundcode_voiceline(host.randi_choice([
				"dorm-boom",
				"dorm-EZ",
				"dorm-predictable",
				"dorm-iknowyourmove",
				"<null>",
				"<null>"
			]), "DORM")
	
	if thing == "got_parried":
		if DORM:
			soundcode_voiceline(host.randi_choice([
				"dorm-bruh",
				"dorm-didnothappen",
				"dorm-noway",
				"dorm-icallBS",
				"dorm-ohmygod",
				"<null>",
				"<null>"
			]), "DORM")
	
	if thing == "got_hit":
		if DORM:
			soundcode_voiceline(host.randi_choice([
				"dorm-ow",
				"dorm-myspleen",
				"dorm-yeowch",
				"<null>",
				"<null>"
			]), "DORM")
			
	if thing == "died":
		if DORM:
			soundcode_voiceline(host.randi_choice([
				"dorm-didilose"
			]), "DORM")
	
#	============================================================================================== >
func _ready():
	host = owner
	music_access = true
	
	if is_instance_valid(Global.current_game):
		var username = Network.pid_to_username(host.id)
		var style = Global.current_game.match_data.selected_styles[host.id]
		var titles = []
		var VIPs = {}
		
		#	--	VIP
		if style and style.get("HKLB-VIPs"):
			var VIP = style["HKLB-VIPs"].get(username)
			
			if VIP:
				var owned_skins = VIP[0]
				
				if skin_enabled == true:
					for available_skin in skins.keys():
						var required_style_name = skins[available_skin]
						
						if available_skin in owned_skins and required_style_name in style.style_name:
							skin = available_skin
				
				var title = style.get("HKLB-Title")
				if title:
					titles.append(title)
					
		var uber = style and style.get("uber")
		var uber_title = "[color=#444444]Uber Oni[/color]"
		
		#	--	AKUMA
		if skin == "Akuma":
			titles.append("[color=#ff0000]The Great Ogre[/color]")
			
			if uber and "Dorm" in style.style_name and style.get("character_color") == Color("#949494"):
				DORM = true
				
				titles.append("[color=#949494]Hardest Working Man on the Planet[/color]")
		
		#	--	UBER ONI
		if style and uber == true:
			if "Uber" in style.style_name:
				skin = "UberOni"
				titles.append("[color=#444444]The Denizen of Hell[/color]")
		
		#	--	TITLE
		render_title(titles, username)

#	--
func _start():
	host.sprite.material.set_shader_param("recolour", false)
	
	if skin == "Akuma":
		host.sprite.material.set_shader_param("recolour", true)
		
		host.sprite.material.set_shader_param("purple_flame_1", Color("#ff0000"))
		host.sprite.material.set_shader_param("purple_flame_2", Color("#bf0000"))
		host.sprite.material.set_shader_param("orange_flame_1", Color("#ff4040"))
		host.sprite.material.set_shader_param("orange_flame_2", Color("#ff0000"))
		host.sprite.material.set_shader_param("red_death", Color("#ff0000"))
		
	elif skin == "UberOni":
		host.sprite.material.set_shader_param("recolour", true)
		
		host.sprite.material.set_shader_param("purple_flame_1", Color("#808080"))
		host.sprite.material.set_shader_param("purple_flame_2", Color("#404040"))
		host.sprite.material.set_shader_param("orange_flame_1", Color("#ffffff"))
		host.sprite.material.set_shader_param("orange_flame_2", Color("#bfbfbf"))
		host.sprite.material.set_shader_param("red_death", Color("#ffffff"))

func _tick():
	
	#	--	VOICELINES
	soundcodes_process()
	
	if skin == "UberOni":
		$"%UBER_Aura".visible = skin == "UberOni"
		$"%UBER_Aura2".visible = skin == "UberOni"

		$"%UBER_Aura2".emitting = host.is_grounded()
		host.sprite.material.set_shader_param("recolour", true)
	
	if skin == "Akuma":
		
		#	--	REPLACEMENTS
		host.sprite.frames = preload("res://_NokGorenShin/characters/shingoren/skins/akuma/SG-SF-AK.tres")
		
		if host.current_tick == 0:
			$"%AK-Halo".visible = true
		
		if host.current_tick in [1, 2, 3]:
			prepare_replace_audio(host)
			
			#var mat = host.sprite.material
			#$"%Mu-Extra2".material = host.sprite.material		
			
		for obj in host.objs_map.values():
			if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == host and obj.current_tick in [1, 2, 3]:
				prepare_replace_audio(obj)
		
		#	--	FX
		host.afterimage(Color("#8fff0000"), 0.1)
		
		if host.applied_style and host.applied_style.get("extra_color_2"):
			$"%AK-Aura".modulate = host.applied_style.get("extra_color_2")
		
		#	--	HURT
		if not host.game_over:
			if host.opponent.combo_count < 1:
				hurt = false
			
			if hurt == false:
				if host.opponent.combo_count > 0 or host.current_state().state_name in ["HurtGrounded", "HurtAerial", "HurtDizzy"]:
					hurt = true
					
					thing_happened("got_hit")
					
					if !DORM:
						akuma_voiceline([
							load("res://_NokGorenShin/characters/shingoren/skins/akuma/voicelines/akm-hurt.wav"),
							load("res://_NokGorenShin/characters/shingoren/skins/akuma/voicelines/akm-hurt2.wav")
						])
				if host.current_state().state_name in ["Grabbed"]:
					host.stop_sound("Voiceline")
				
		#	--	DEATH
		if host.game_over == true and won == false:
			if !(host.id == 2 and skin == "Akuma" and (host.opponent.get_node("%Stuff") and host.opponent.get_node("%Stuff").get("skin") == "Akuma")):
				won = true
				var ko_target = host if host.hp < 0 else host.opponent
				var ko_pos = ko_target.get_pos()
				
				#	--
				ko_target.grab_camera_focus()
				
				var win_label = get_tree().get_current_scene().get_node("%WinLabel")
				if win_label:
					
					win_label.modulate.a = 1
					win_label.text = "K.O."
					
				Global.current_game.camera_zoom = 0.5
				Global.current_game.game_end_tick += 45
				
				#	--
				host.play_sound("AK_KO")
				host.spawn_particle_effect(preload("res://_NokGorenShin/characters/shingoren/skins/akuma/effects/SGAK-KO.tscn"), Vector2(ko_pos.x, ko_pos.y - 18))
				host.screen_bump(Vector2(0, 0), 4, 0.25)
				
				host.global_hitlag(45)
				host.hitlag_ticks = 45
				host.opponent.hitlag_ticks = 45
				
				if host.hp > 0:
					host.state_machine.queue_state("Taunt")
					
				else:
					if death_quoted == false:
						death_quoted = true
					
						thing_happened("died")
					
						if !DORM:
							akuma_voiceline([load("res://_NokGorenShin/characters/shingoren/skins/akuma/voicelines/akm-death.wav")])
				
		elif host.game_over == true and host.hitlag_ticks < 1:
			host.release_camera_focus()
				
			var win_label = get_tree().get_current_scene().get_node("%WinLabel")
			if win_label:
				win_label.modulate.a = lerp(win_label.modulate.a, 0, 0.1)
					
			var camera = host.get_camera()
			if camera:
				Global.current_game.camera_zoom = lerp(Global.current_game.camera_zoom, 1, 0.1)
	
	if host.game_over == true and host.hp > 0 and won2 == false:
		won2 = true
		
		$"%Stuff".unlock_achievement("SG-WIN")		
