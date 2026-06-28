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
	"Mentenner": "Mandate"
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
	
		#	--	JSON READING
		var new_file = File.new()
		new_file.open("res://_NokHekkenslib/VIP.json", new_file.READ)
		var json_data = parse_json(new_file.get_as_text())
		if json_data and json_data.get("Colossus"):
			VIPs = json_data.Colossus
		
		new_file.close()
		
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
	pass

#	--
func _process(d):
	pass
