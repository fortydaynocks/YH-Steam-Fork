extends Node

#	-----------------------------------------------------------------------------------------------
var host
var tweens = {
	"emote_tween": create_tween(),
}

var skin_enabled = true
var skin = null
var soundbytes_left = 0
var style_colors = false

var skins = {
	"Astaroth": "Mandate"
}

var quotes_col = {
	"Intro": {
		"BigSword": [
			"A worthy opponent!",
		],
		
		"Unbridled": [
			"A worthy opponent!",
		],
		
		"Tyrant": [
			"The embers of a dragon...",
		],
		
		"Colossus": [
			"The only true match.",
		],
		
		"Guardian": [
			"What weak fortitude!",
			"That defense shall not hold.",
			"Behold, the unstoppable.",
		],
		
		"Niflheim": [
			"Your blade intrigues me.",
			"You believe you know flame?",
		],
		
		"Revenant": [
			"This is your test, Christian.",
		],
		
		"Torment": [
			"You shackle me no longer.",
			"It's finally time.",
			"Brace yourself, Hellsaint.",
		],
		
		"Camila": [
			"Today your 'Vision' sees no longer.",
			"Your wicked self shall weep.",
			"You interest me not, harlot.",
		],
		
		"_": [
			"Step forth.",
			"You challenge me?",
			"Prepare yourself.",
			"Stand ready.",
			"Very well."
		],
	},
	"ThisWorldCries": {
		"Colossus": [
			["You could never be myself...", "[shake rate=40 level=10 connected=1][color=#fbf236]BEGONE!"],
			["Such a pitiful clone!", "[shake rate=40 level=10 connected=1][color=#fbf236]DIE!"],
			["That sword...", "[shake rate=40 level=10 connected=1][color=#fbf236]YOU DESERVE IT NOT."],
		],
		"Unbridled": [
			["This is the power...", "[shake rate=40 level=10 connected=1][color=#ffffff]I HUNGERED FOR!"],
			["Show me your strength...", "[shake rate=40 level=10 connected=1][color=#ffffff]ALL OF IT!"],
			["Rise up, warrior...", "[shake rate=40 level=10 connected=1][color=#fbf236]OR FALL TO THE ABYSS!"],
		],
		"Revenant": [
			["Show me you're worthy...", "[shake rate=40 level=10 connected=1][color=#fbf236]CHRISTIAN!"],
			["Stand up...", "[shake rate=40 level=10 connected=1][color=#fbf236]WARRIOR OF FLAME!"],
			["My son...", "[shake rate=40 level=10 connected=1][color=#fbf236]RISE UP!"],
		],
		"Torment": [
			["The wretched Hellsaint...", "[shake rate=40 level=10 connected=1][color=#ff0044]EMBRACE THE END!"],
			["My faith...", "[shake rate=40 level=10 connected=1][color=#ff0044]SHALL NOT WAVER."],
			["Eradication is...", "[shake rate=40 level=10 connected=1][color=#ff0044]YOUR DESTINY."],
			["You evil beast...", "[shake rate=40 level=10 connected=1][color=#ff0044]DIE!"],
		],
		"Camila": [
			["Begone...", "[shake rate=40 level=10 connected=1][color=#ff0000]FOUL TEMPTRESS!"],
			["Do you REALLY think...", "[shake rate=40 level=10 connected=1][color=#ff0000]YOU CAN TAME ME?!"],
			["You wicked vixen...", "[shake rate=40 level=10 connected=1][color=#ff0044]REPENT!"],
		],
		"_": [
			["Bow before the...", "[shake rate=40 level=10 connected=1][color=#fbf236]BLADE!"],
			["I shall purge you.", "[shake rate=40 level=10 connected=1][color=#fbf236]DIE!"],
			["To the depths you...", "[shake rate=40 level=10 connected=1][color=#fbf236]FALL!"],
			["A pitiful display.", "[shake rate=40 level=10 connected=1][color=#fbf236]DIE!"],
			["This is your...", "[shake rate=40 level=10 connected=1][color=#fbf236]END!"],
			["By the Godblight...", "[shake rate=40 level=10 connected=1][color=#fbf236]BURN!"],
		],
	},
}

var quotes_asta = {
	"Intro": {
		"Astaroth": [
			"How amusing!",
			"Soulmates!",
		],
		"Torment": [
			"I'd love to try out those powers...",
			"What a mighty SOUL!",
			"This harvest will be PERFECT!",
			"It's the end, HELLSAINT...!",
		],
		"Colossus": [
			"Show me more of that POWER!",
			"What a powerful SOUL!",
			"I'll ENJOY THIS...",
		],
		"Aimorrago": [
			"A little out of my league...",
			"Oh, WOW!",
			"What an opportunity...",
		],
		"Camila": [
			"What a BEAUTIFUL soul!",
			"Don't mind if I do~",
			"JACKPOT!!",
			"Remember this face well, lady...",
		],
		"_": [
			"HAHAHAHA...",
			"This will be FUN!",
			"Your SOUL is MINE!",
			"PREPARE yourself!",
			"The REAPER cometh...",
			"Is this a WISE CHOICE?",
			"Heed the SOULGOD!"
		]
	},
	"ThisWorldCries": {
		"_": [
			["I'll cut you...", "[shake rate=40 level=10 connected=1][color=#00ff95]INTO PIECES!"],
			["Do you even know...", "[shake rate=40 level=10 connected=1][color=#00ff95]WHO YOU'RE UP AGAINST?!"],
			["HAHAHAHA...", "[shake rate=40 level=10 connected=1][color=#00ff95]DIE!"],
			["Grimothy...", "[shake rate=40 level=10 connected=1][color=#00ff95]END THEIR LIFE!"],
			["You never stood a chance...", "[shake rate=40 level=10 connected=1][color=#00ff95]TOO BAD!"],
			["Is that all...", "[shake rate=40 level=10 connected=1][color=#00ff95]YOU'VE GOT?!"],
		],
	}
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

func do_text(quote = "...", extra_time = 0):
	if ReplayManager.resimulating == true: return
	
	if is_instance_valid($"%Emote"):
		if tweens.emote_tween: tweens.emote_tween.kill()
		
		$"%Emote".bbcode_text = "[center]" + quote
		$"%Emote".percent_visible = float(0)
		$"%Emote".modulate = Color(1, 1, 1, 1)
		
		var t = len($"%Emote".text) * 0.025
		soundbytes_left = round(len($"%Emote".text) * 0.5)
		
		tweens.emote_tween = create_tween()
		tweens.emote_tween.tween_property($"%Emote", "percent_visible", float(1), t)
		tweens.emote_tween.tween_property($"%Emote", "modulate", Color(1, 1, 1, 0), t + 0.25 + extra_time)

func choose_text(charname, quote_choice = "Intro", quote_set = quotes_col):
	if host:
		if charname and quote_set[quote_choice].get(charname):
			return host.randi_choice(quote_set[quote_choice][charname])
			
		else:
			return host.randi_choice(quote_set[quote_choice]._)
			
func recursive_style_modulation(obj):
	if host.applied_style and obj.get("modulate"):
		if host.applied_style.get("extra_color_1"):
			if obj.modulate.is_equal_approx(Color("686f99")):
				obj.modulate = host.applied_style.extra_color_1
		
		if host.applied_style.get("extra_color_2"):
			if obj.modulate.is_equal_approx(Color("fbf236")):
				obj.modulate = host.applied_style.extra_color_2.lightened(0.5)
			
			if obj.modulate.is_equal_approx(Color("ff8933")):
				obj.modulate = host.applied_style.extra_color_2.lightened(0.2)
		
		for child in obj.get_children():
			recursive_style_modulation(child)

#	-----------------------------------------------------------------------------------------------
func _ready():
	host = owner
	
	if Global.current_game:
		var style = Global.current_game.match_data.selected_styles[host.id]
		var titles = []
		var no_title = false
		var as_title = "[color=#00ff95]Ultimate Soul Collector[/color]"
		var VIPs = {}
	
		if ResourceLoader.exists("res://_NokHekkenslib/VIP.tres"):
			VIPs = ResourceLoader.load("res://_NokHekkenslib/VIP.tres").list
			if VIPs.get("Colossus"): VIPs = VIPs.Colossus
		
		#	--
		var username = Network.pid_to_username(host.id)
		if username in VIPs:
			var owned_skins = VIPs[username][0]
			#var title = VIPs[username][1]
			var title = style.get("custom_title")
			var title_color = style.get("custom_title_color")
			
			#	--	SKIN
			if skin_enabled == true and style and style.style_name:
				for available_skin in skins.keys():
					var required_style_name = skins[available_skin]
					
					if available_skin in owned_skins and (required_style_name in style.style_name or "Mandate" in style.style_name):
						skin = available_skin
						
				if title != "<NO-TITLE>":
					title = "[color=#" + title_color + "]" + title + "[/color]"
					titles.append(title)
					
				else:
					no_title = true
					
			#	--	STYLE COLORS
			style_colors = true
		
		if skin == "Astaroth" and no_title == false:
			titles.append(as_title)
		
		#	--	TITLE
		render_title(titles, username)		
		
					
		#	--	ICON SETUP
		var main_scene = host.get_tree().get_current_scene()
		var buttons = main_scene.get_node("%P1ActionButtons") if host.id == 1 else main_scene.get_node("%P2ActionButtons")
		var desc_labels = buttons.get_node("%CategoryContainer")
			
		#	--	COLORED ICONS
		if desc_labels:
			for control in desc_labels.get_children():
				if control.get_node_or_null("OrbsLabel") == null:
					for action_button in buttons.buttons:
						
						var state = action_button.get("state")
						if state and "ReqFlame" in state.editor_description and action_button.get_node("Button").get_node_or_null("FireIconDeco") == null:
							var texture = $"%FireIconDeco".duplicate()
							action_button.get_node("Button").add_child(texture)
							
							texture.visible = state.get("minimum_flames") > 0
							texture.get_node("Cost").text = str(state.get("minimum_flames"))
						
#	--
func _start():
	pass
	
#	--		
func _tick():
	if soundbytes_left > 0 and host.current_tick % 2 == 0:
		host.play_sound("Soundbyte")
		soundbytes_left -= 1
		
	if skin == "Astaroth":
		host.charname = "Astaroth"

#	--
func _process(d):
	if host.sprite:
		if style_colors:
			host.sprite.material.set_shader_param("use_fire_shader", true)
			
		if skin == "Astaroth":
			host.sprite.frames = preload("res://_NokColossusR/characters/colossus/skins/astaroth/CSR-SF-AS.tres")
			host.sprite.material.set_shader_param("astaroth_mode", true)
			host.sprite.material.set_shader_param("as_counter", host.lordflame.Value)
			
			#if host.applied_style and not host.applied_style.get("extra_color_2"):
				#host.applied_style.extra_color_2 = Color("#00ff95")
				#host.sprite.material.set_shader_param("use_extra_color_2", true)
				#host.sprite.material.set_shader_param("extra_color_2", Color("#00ff95"))
