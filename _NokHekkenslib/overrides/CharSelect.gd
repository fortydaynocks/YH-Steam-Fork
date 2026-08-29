extends "res://ui/CSS/CharacterSelect.gd"

func get_match_data():
	var data = .get_match_data()
	
#	print("THIS IS RUNNING")
	
	if self.singleplayer:
		var hklb = get_node_or_null("/root/Main/UILayer/Hekkenslib")
		if hklb and data is Dictionary:
			var selected_characters = data.get("selected_characters", {})
			var selected_styles = data.get("selected_styles", {})
			
			if selected_characters is Dictionary and selected_styles is Dictionary:
				for plr_id in selected_characters.keys():
					var character_data = selected_characters.get(plr_id, {})
					if not character_data is Dictionary:
						continue
					var chr = str(character_data.get("name", ""))
					if chr == "":
						continue
					var style = selected_styles.get(plr_id, null)
					selected_styles[plr_id] = hklb.edit_style_data(chr, style)
#					print("THIS IS DEFINITELY 100% RUNNING")
	
	return data
	

