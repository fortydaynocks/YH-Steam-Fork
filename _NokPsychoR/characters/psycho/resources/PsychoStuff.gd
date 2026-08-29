extends Node

#	-----------------------------------------------------------------------------------------------
export (Dictionary) var objs
export (Dictionary) var vfx

var tweens = {
	"emote_tween": create_tween(),
}
var colors = {}

var host
var skin_enabled = true
var skin = null
var music_access = false
var do_skin_afterimage = true
var soundbytes_left = 0

var win_quoted = false

var skins = {
	"Aimorrago": "Mandate",
	"Guillotine": "Beheaded",
}

#	--
var ai_quotes = {
	"SilentTreatment": [
		"....",
		".......",
		"...Does it hurt?",
		"...Sorry.",
		"...That's enough.",
	],
	"Insanity": [
		"......",
		"...I don't like you.",
		"...I'm mad.",
		"...Stop.",
		"...You will die.",
		"...Go away.",
	],
	"GSOO": [
		"...Die.",
		"...Goodbye.",
		"...The end... is here.",
		"...It's over.",
	],
	"GameVictory": [
		".........",
		"...Goodbye.",
		"...Time's up.",
		"...Bleed.",
		"...That's all.",
	],
	"GameLoss": [
		"...no...",
		"...This can't... be it...",
		"...Help... me...",
		"...Why...",
	],
}

#	--
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

func do_title(text):
	if host.is_ghost == false:
		$"%Title".bbcode_text = text
		$"%Title".modulate = Color(1, 1, 1, 0.5)
		
		if tweens.has("Title"): tweens.Title.kill()
		else: tweens.Title = null
			
		tweens.Title = create_tween()
		tweens.Title.tween_property($"%Title", "modulate", Color(1, 1, 1, 0), 2)

func do_text(quote = "..."):
	if ReplayManager.resimulating == true: return
	
	if is_instance_valid($"%Emote"):
		if tweens.emote_tween: tweens.emote_tween.kill()
		
		$"%Emote".bbcode_text = "[center]" + quote
		$"%Emote".percent_visible = float(0)
		$"%Emote".modulate = Color(1, 1, 1, 1)
		
		var t = len(quote) * 0.025
		
		if skin == "Aimorrago":
			soundbytes_left = round(len(quote) * 0.75)
		
		tweens.emote_tween = create_tween()
		tweens.emote_tween.tween_property($"%Emote", "percent_visible", float(1), t)
		tweens.emote_tween.tween_property($"%Emote", "modulate", Color(1, 1, 1, 0), t + 0.25)

#	--
func _ready():
	host = owner
	
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
				
				#	--	SKIN
				if skin_enabled == true:
					for available_skin in skins.keys():
						var required_style_name = skins[available_skin]
						
						if available_skin in owned_skins and required_style_name in style.style_name:
							skin = available_skin
				
				#	--	TITLE
				var title = style.get("HKLB-Title")
				if title:
					titles.append(title)
			
				#	--	PRIVELEGES
				if not "NoMusic" in owned_skins:
					music_access = true
			
			#	--	SKIN EFFECTS			
			if skin == "Aimorrago":
				titles.append("[color=#ff0000]Immortal Chords[/color]")
				host.charname = "Aimorrago"
				
				if "[~]" in style.style_name:
					do_skin_afterimage = false
				
				#	--	UNIQUE COLORS
				#	--	MAYBE MAKE THIS WORK SOMEDAY.
				# host.use_extra_color_1 = true
			
				var main_scene = get_tree().get_current_scene()
				var buttons = main_scene.get_node("%P1ActionButtons") if host.id == 1 else main_scene.get_node("%P2ActionButtons")
				for action_button in buttons.buttons:
					if action_button.action_name == "insanity":
						action_button.get_node("%TextureRect").texture = preload("res://_NokPsychoR/characters/psycho/skins/aimorrago/icons/ps-ai-icon-oxaban.png")
						action_button.action_title = "Oxaban"
					if action_button.action_name == "gsoo":
						action_button.get_node("%TextureRect").texture = preload("res://_NokPsychoR/characters/psycho/skins/aimorrago/icons/ps-ai-icon-annihilus.png")
						action_button.action_title = "Annihilus"
					if action_button.action_name == "gsoo2":
						action_button.get_node("%TextureRect").texture = preload("res://_NokPsychoR/characters/psycho/skins/aimorrago/icons/ps-ai-icon-annihilus.png")
						action_button.action_title = "Annihilus"
			
			if skin == "Guillotine":
				titles.append("[color=#8f8f8f]SENTENCED TO DEATH[/color]")
			
			#	--	TITLE
			render_title(titles, username)

func convert_particle_color(effect):
	if effect.modulate.r == host.extra_color_1.r and effect.modulate.g == host.extra_color_1.g and effect.modulate.b == host.extra_color_1.b:
		if host.use_extra_color_1 == true and host.applied_style and host.applied_style.get("extra_color_1"):
			effect.modulate = host.applied_style.get("extra_color_1")
	
	for particle in effect.get_children():
		if particle is CPUParticles2D:
			if host.use_extra_color_1 == true and host.applied_style and host.applied_style.get("extra_color_1") and particle.modulate == host.extra_color_1:
				particle.modulate = host.applied_style.get("extra_color_1")
				
	return effect
	
func guillotine_modulation(obj):
	if obj.get("modulate") and obj.modulate.is_equal_approx(Color("ff0000")):
			obj.modulate = Color("8f8f8f")
			
	if obj.get("color") and obj.color.is_equal_approx(Color("ff0000")):
			obj.color = Color("8f8f8f")
			
	if obj.get("color_ramp"):
		var i = 0
		
		for color in obj.color_ramp.colors:
			if color.is_equal_approx(Color("ff0000")):
				obj.color_ramp.set_color(i, Color("8f8f8f"))
				
			i += 1
	
	for child in obj.get_children():
		guillotine_modulation(child)

#	--
func _start():
	pass

func _tick():
	if skin == "Aimorrago" and host.game_over == true and win_quoted == false:
		win_quoted = true
		
		if host.hp > 0:
			do_text(host.randi_choice(ai_quotes.GameVictory))
			
		else:
			do_text(host.randi_choice(ai_quotes.GameLoss))
			
	if skin == "Aimorrago":
		var portrait
		match host.id:
			1:
				portrait = host.get_node_or_null("/root/Main/%P1Portrait")
			
			2:
				portrait = host.get_node_or_null("/root/Main/%P2Portrait")
		if portrait:
			portrait.texture = preload("res://_NokPsychoR/characters/psycho/skins/aimorrago/sprites/psportrait-AI.png")
	
	if skin == "Guillotine":
		guillotine_modulation(host)
		
		host.sprite.material.set_shader_param("use_extra_color_1", true)
		host.sprite.material.set_shader_param("extra_replace_color_1", host.extra_color_1)
		host.sprite.material.set_shader_param("extra_color_1", Color("8f8f8f"))
	
func _process(d):
	if soundbytes_left > 0 and host.current_tick % 2 == 0:
		host.play_sound("AISoundbyte")
		soundbytes_left -= 1
