extends Node

#	-------------------------------------------------------------------------- |
var tweens = {
	"emote_tween": create_tween(),
}

var host
var skin_enabled = true
var skin = null
var music_access = false
var do_skin_afterimage = true
var soundbytes_left = 0

var sword_in_hand = false

var skins = {
	"Munanyou": "Mandate"
}

#	-------------------------------------------------------------------------- |
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
			
func recursive_style_modulation(obj):
	if host.applied_style and obj.get("modulate"):
		if host.applied_style.get("extra_color_1") and obj.modulate.is_equal_approx(Color("006aff")):
			obj.modulate = host.applied_style.extra_color_1
			
		if host.applied_style.get("extra_color_2") and obj.modulate.is_equal_approx(Color("5300ff")):
			obj.modulate = host.applied_style.extra_color_2
		
		for child in obj.get_children():
			recursive_style_modulation(child)

func replace_audio(obj, initial, new):
	if initial and new:
		for child in obj.get_children():
			if child.get("stream"):
				if child.stream.resource_path == initial:
					child.stream = load(new)
				
			replace_audio(child, initial, new)
		
func prepare_replace_audio(obj):
	replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slash1.wav", "res://_NokBetrayer/characters/betrayer/skins/munanyou/sounds/mu-slashALT-1.wav")
	replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slash2.wav", "res://_NokBetrayer/characters/betrayer/skins/munanyou/sounds/mu-slashALT-2.wav")
	replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slash3.wav", "res://_NokBetrayer/characters/betrayer/skins/munanyou/sounds/mu-slashALT-3.wav")
	
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slashB-1.wav", "res://characters/swordandgun/sounds/swing1.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slashB-2.wav", "res://characters/swordandgun/sounds/swing2.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slashB-3.wav", "res://characters/swordandgun/sounds/swing3.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slashB-4.wav", "res://characters/swordandgun/sounds/swing4.wav")
	
	replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/hit1.wav", "res://_NokBetrayer/characters/betrayer/skins/munanyou/sounds/mu-hit1.wav")
	replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/hit2.wav", "res://_NokBetrayer/characters/betrayer/skins/munanyou/sounds/mu-hit2.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slice1.wav", "res://sound/common/slash1.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slice2.wav", "res://sound/common/slash2.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slice3.wav", "res://sound/common/slash3.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/slice4.wav", "res://sound/common/slash4.wav")

	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/hitbass.wav", "res://sound/common/explosion1.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/hitbass2.wav", "res://sound/common/explosion2.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/hitbass3.wav", "res://sound/common/explosion3.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/hitbass4.wav", "res://sound/common/explosion4.wav")
	
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/gore1.wav", "res://sound/common/burst.wav")
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/gore2.wav", "res://sound/common/burst.wav")
	
	#replace_audio(obj, "res://_NokBetrayer/characters/betrayer/sounds/bell-bofr.wav", "res://sound/ui/multiplayer_fight_start.wav")
#	-------------------------------------------------------------------------- |
func _ready():
	host = owner
	music_access = true
	var VIPs = {}
	
	if ResourceLoader.exists("res://_NokHekkenslib/VIP.tres"):
		VIPs = ResourceLoader.load("res://_NokHekkenslib/VIP.tres").list
		if VIPs.get("Betrayer"): VIPs = VIPs.Betrayer
	
	#	--	PROCESSING
	if is_instance_valid(Global.current_game):
		var style = Global.current_game.match_data.selected_styles[host.id]
		var titles = []
		
		#	--	VIP
		var username = Network.pid_to_username(host.id)
		if username in VIPs:
			var owned_skins = VIPs[username][0]
			var title = VIPs[username][1]
			
			#	--	SKIN
			if skin_enabled == true and style and style.style_name:
				for available_skin in skins.keys():
					var required_style_name = skins[available_skin]
					
					if available_skin in owned_skins and (required_style_name in style.style_name or "Mandate" in style.style_name):
						skin = available_skin
						
				if title != "<NO-TITLE>":
					titles.append(title)
		
		if skin == "Munanyou":
			host.charname = "Munanyou"
			titles.append("[color=#9e7deb]Divine Lightning[/color]")
		
		#	--	TITLE
		render_title(titles, username)
					
func _start():
	pass

func _tick():
	host.skin = skin
	
	if skin == "Munanyou":
		host.sprite.frames = preload("res://_NokBetrayer/characters/betrayer/skins/munanyou/BT-SF-Munanyou.tres")
		
		if host.current_tick == 1:
			prepare_replace_audio(host)
			
			var mat = host.sprite.material
			$"%Mu-Extra2".material = host.sprite.material		
			
		for obj in host.objs_map.values():
			if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == host and obj.current_tick in [1, 2, 3]:
				prepare_replace_audio(obj)
				
		#	--	SWORD SHOWING AND HIDING
		if !host.is_ghost:
			if sword_in_hand == false:
				if "UseMuSword" in host.current_state().get("editor_description"):
					sword_in_hand = true
					
					$"%Mu-Extra2".self_modulate.a = 0
					
					host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar2.tscn"), $"%Mu-Extra2".position + Vector2(-16, -4))
					host.play_sound("Mu-Unsheath")
					
			elif sword_in_hand == true:
				if not "UseMuSword" in host.current_state().get("editor_description"):
					sword_in_hand = false
					
					$"%Mu-Extra2".self_modulate.a = 1
					
					host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar2.tscn"), $"%Mu-Extra2".position + Vector2(-16, -4))
					host.play_sound("Mu-Sheath")
		
