extends Control

var VIPs = preload("res://_NokHekkenslib/VIP.tres")
var data_directory = "user://hekkenslib.json"

var data_file
var atlases = {}
var current_character

var blank_style = {
	"character_color": null,
	"outline_color": null,
	"show_aura": false,
	"style_name": "",
	"use_outline": false,
	}

#	========================================================================== >
func my_name():
	if Network.multiplayer_active:
		return Network.get_player_name()
	return Global.get_player_data().username

func edit_style_data(chr, style):
	var chr_name = ""
	if chr is Dictionary:
		chr_name = str(chr.get("name", ""))
	elif chr != null:
		chr_name = str(chr)
	else:
		return style
	
	if "__" in chr_name:
		var split_name = chr_name.rsplit("__", 1)
		chr_name = split_name[split_name.size() - 1]
	
	if not style is Dictionary:
		style = blank_style.duplicate(true)
	else:
		style = style.duplicate(true)
	
	if chr_name in VIPs.list.keys():
		style["HKLB-VIPs"] = VIPs.list[chr_name]
	
		var title_options = get_node_or_null("%TitleOptions")
		if is_instance_valid(title_options):
			var title = title_options.fetch_title(chr_name)
			if title:
				style["HKLB-Title"] = title
	
	return style


#	========================================================================== >
func open_menu():
	self.visible = true
	
	$"%TitleOptions".load_titles()

func exit():
	self.visible = false
	save()
	
func save():
	if current_character:
		var new_file = File.new()
		new_file.open(data_directory, new_file.READ)
		
		var json_data = parse_json(new_file.get_as_text())
		var save_data = {}
		
		if json_data == null:
			new_file.store_string(JSON.print({}))
			json_data = {}
		
		for option in $"%CharOptions".get_children():
			var value = option.value_object
			var value_name = option.value_name
			var actual_value = option.actual_value
			
			if actual_value == null:
				actual_value = atlases[current_character][value_name][1]
			
			save_data[value_name] = actual_value
			
		new_file.open(data_directory, new_file.WRITE)
		json_data[current_character] = save_data
		new_file.store_string(JSON.print(json_data, "	"))
		
		new_file.close()
		
#	========================================================================== >


#	========================================================================== >
func refresh_file():
	$"%JSONError".visible = false
	
	var new_file = File.new()
	if !new_file.file_exists(data_directory):	#	--	creates new file if nonexistent
		new_file.open(data_directory, new_file.WRITE_READ)
		new_file.store_string("{}")
	new_file.close()

#	========================================================================== >
func _on_Exit_pressed():
	save()
	exit()
		
#	========================================================================== >
func _ready():
	refresh_file()

func _setup_finished():
	pass

func game_started():
	var game = self.get_owner()
	
