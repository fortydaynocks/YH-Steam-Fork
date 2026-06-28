extends Node

#	-----------------------------------------------------------------------------------------------
var VIPs = {
	"Shin Goren": [["Akuma", "UberOni"], "<NO-TITLE>"],
	
	"nok": [["Akuma"], "[color=#ff8933]Gokormorath's Ancient Rage[/color]"],
	"WriterNat": [["Akuma"], "[color=#ff0000]The Honorary Raging Demon[/color]"],
	"Sleepy_Dorm": [["Akuma"], "[color=#ff0000]The Honorary Raging Demon[/color]"],
	"steph": [["Akuma"], "A Raging Demon"],
	"Mana": [["Akuma"], "A Raging Demon"],
	"HitsuuDesu": [["Akuma"], "A Raging Demon"],
	"Cherry": [["Akuma"], "A Raging Demon"],
	"kerelzlow": [["Akuma"], "A Raging Demon"],
	"Korbus": [["Akuma"], "A Raging Demon"],
	"MuttDud": [["Akuma"], "A Raging Demon"],
	"Trinity": [["Akuma"], "A Raging Demon"],
	"Pres": [["Akuma"], "A Raging Demon"],
	"Death": [["Akuma"], "A Raging Demon"],
	"soopernoob": [["Akuma"], "A Raging Demon"],
	"visualoverload": [["Akuma"], "A Raging Demon"],
	"Ali, Master of Hands": [["Akuma"], "A Raging Demon"],
	"Gekuyom": [["Akuma"], "A Raging Demon"],
	"Ceiling": [["Akuma"], "A Raging Demon"],
	"IppoDarkieSlayer": [["Akuma"], "A Raging Demon"],
	"CaptN cruuunch": [["Akuma"], "A Raging Demon"],
	"Nezriani": [["Akuma"], "A Raging Demon"],
	"N.O.X": [["Akuma"], "A Raging Demon"],
	"King Kani": [["Akuma"], "A Raging Demon"],
	"Admiral Kidd": [["Akuma"], "A Raging Demon"],
	"CTM9001": [["Akuma"], "A Raging Demon"],
	"Skydarts": [["Akuma"], "A Raging Demon"],
	"MCHurt12": [["Akuma"], "A Raging Demon"],
	"Draedon": [["Akuma"], "A Raging Demon"],
	"Anna Mae": [["Akuma"], "A Raging Demon"],
	"samuraiarceus": [["Akuma"], "A Raging Demon"],
	"Ataz": [["Akuma"], "A Raging Demon"],
	"TheSolarInferno": [["Akuma"], "Self-Proclaimed Spite"],
	"Script": [["Akuma"], "A U T I S M"],
}

#	-----------------------------------------------------------------------------------------------
var tweens = {
	"emote_tween": create_tween(),
}
var colors = {}

var host
var skin_enabled = true
var skin = null
var music_access = false

var hurt = false
var won = false
var won2 = false
var death_quoted = false

var skins = {
	"Akuma": "Mandate", # previously "Essence of Akuma"
	"UberOni": "Uber"
}

#	-----------------------------------------------------------------------------------------------
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
		if obj.modulate.is_equal_approx(Color("ff441a")) or obj.modulate.is_equal_approx(Color("ff0044")):
			obj.modulate = Color("ff8f8f")
		
		if obj.modulate.is_equal_approx(Color("d10753")) or obj.modulate.is_equal_approx(Color("cc2f7b")):
			obj.modulate = Color("ff0000")
		
		if obj.modulate.is_equal_approx(Color("9f07d0")):
			obj.modulate = Color("8f0000")
		
func uber_modulation(obj):
	if obj.get("modulate"):
		if obj.modulate.is_equal_approx(Color("ff441a")) or obj.modulate.is_equal_approx(Color("ff0044")):	
			obj.modulate = Color("ffffff")
		
		if obj.modulate.is_equal_approx(Color("d10753")) or obj.modulate.is_equal_approx(Color("cc2f7b")):
			obj.modulate = Color("8f8f8f")
		
		if obj.modulate.is_equal_approx(Color("9f07d0")):
			obj.modulate = Color("2f2f2f")
	
func recursive_style_modulation(obj):
	if skin == "Akuma":
		if obj.get("modulate"):
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_purple_flame_1")):
				obj.modulate = host.sprite.material.get_shader_param("purple_flame_1")
				
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_purple_flame_2")):
				obj.modulate = host.sprite.material.get_shader_param("purple_flame_2")
				
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_orange_flame_1")):
				obj.modulate = host.sprite.material.get_shader_param("orange_flame_1")
				
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_orange_flame_2")):
				obj.modulate = host.sprite.material.get_shader_param("orange_flame_2")
				
			if obj.modulate.is_equal_approx(host.sprite.material.get_shader_param("og_red_death")):
				obj.modulate = host.sprite.material.get_shader_param("red_death")
				
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
	
#	-----------------------------------------------------------------------------------------------
func unlock_achievement(ach, allow_offline = false, relock_after = false):
	if host.is_ghost: return
		
	var codex = get_node_or_null("/root/CharCodexLibrary")
	
	if is_instance_valid(codex):
		if Network.multiplayer_active or allow_offline == true:
			codex.unlock_achievement(host, ach)
		
			if relock_after == true:
				codex.relock_achievement(host, ach)
	
#	-----------------------------------------------------------------------------------------------
func _ready():
	host = owner
	
	if is_instance_valid(Global.current_game):
		var style = Global.current_game.match_data.selected_styles[host.id]
		var uber = style and style.get("uber")
		var titles = []
		
		var uber_title = "[color=#444444]Uber Oni[/color]" #if style.get("uber") else ""
		
		#	--	VIP
		var username = Network.pid_to_username(host.id)
		if username in VIPs:
			var owned_skins = VIPs[username][0]
			var title = VIPs[username][1]
			
			music_access = true
			
			#	--	SKIN
			if skin_enabled == true and style and style.style_name:
				for available_skin in skins.keys():
					var required_style_name = skins[available_skin]
					
					if available_skin in owned_skins and required_style_name in style.style_name:
						skin = available_skin
		
				if title != "<NO-TITLE>":
					titles.append(title)
		
		if skin == "Akuma":
			titles.append("[color=#ff0000]The Great Ogre[/color]")
		
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
	#print(host.sprite.material.get_shader_param("recolour"))
	
	if skin == "UberOni":
		$"%UBER_Aura".visible = skin == "UberOni"
		$"%UBER_Aura2".visible = skin == "UberOni"

		$"%UBER_Aura2".emitting = host.is_grounded()
		host.sprite.material.set_shader_param("recolour", true)
	
	if skin == "Akuma":
		
		#	--	HURT
		if not host.game_over:
			if host.opponent.combo_count < 1:
				hurt = false
			
			if hurt == false:
				if host.opponent.combo_count > 0 or host.current_state().state_name in ["HurtGrounded", "HurtAerial", "HurtDizzy"]:
					hurt = true
					
					akuma_voiceline([
						load("res://_NokGorenShin/characters/shingoren/skins/akuma/voicelines/akm-hurt.wav"),
						load("res://_NokGorenShin/characters/shingoren/skins/akuma/voicelines/akm-hurt2.wav")
					])
				if host.current_state().state_name in ["Grabbed"]:
					host.stop_sound("Voiceline")
				
		#	--	DEATH
		if host.game_over == true and won == false:
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
				
