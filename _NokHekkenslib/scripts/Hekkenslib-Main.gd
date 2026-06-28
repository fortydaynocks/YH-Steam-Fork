extends Control

onready var exit = $"%Exit"
onready var character_search = $"%CharacterSearch"
onready var options = $"%CharOptions"

var data_directory = "user://hekkenslib.json"
var data_file
var atlases = {}
var current_character

#	--
func get_closest_character_match(input):
	if not input in [null, "", " "]:
		var char_name = ""
		var score = INF
		
		for matchTo in atlases.keys():
			var new_score = matchTo.findn(input)
			if new_score < score and new_score != -1:
				char_name = matchTo
				score = new_score
			
		if char_name != "":
			return char_name

func create_options_from_atlas(atlas):
	for option in atlas.keys():
		var option_val = atlas[option]
		
		var new_opt_obj
		match option_val[0]:
			"string":
				new_opt_obj = $"%StringOption".duplicate()
				new_opt_obj.type = "string"
			"bool":
				new_opt_obj = $"%BoolOption".duplicate()
				new_opt_obj.type = "bool"
			"number":
				new_opt_obj = $"%NumberOption".duplicate()
				new_opt_obj.type = "number"
				
		if new_opt_obj:
			new_opt_obj.host = self
			new_opt_obj.value_name = option
			new_opt_obj.get_node("Display").text = option + ": "
			
			if new_opt_obj.type == "string":
				new_opt_obj.get_node("Value").text = option_val[1]
			if new_opt_obj.type == "bool":
				new_opt_obj.get_node("Value").pressed = option_val[1]
			if new_opt_obj.type == "number":
				new_opt_obj.get_node("Value").value = option_val[1]
				if option_val[2]: new_opt_obj.get_node("Value").min_value = option_val[2]
				if option_val[3]: new_opt_obj.get_node("Value").max_value = option_val[3]
			
			$"%CharOptions".add_child(new_opt_obj)

func purge_options():
	for victim in $"%CharOptions".get_children():
		victim.queue_free()

func get_library():
	return $"%LibScript"
	
func character_setup(char_name, char_obj, style):
	var data = get_library().get_all_atlas_data(char_name)

func get_atlas_data(char_obj, value):
	if char_obj.applied_style.has("hklb-data"):
		if value in char_obj.applied_style["hklb-data"].has(value):
			return char_obj.applied_style["hklb-data"].value
	
#	--------------------------------------------------------------------------------------------- |
func open_menu():
	self.visible = true

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

#	--------------------------------------------------------------------------------------------- |
func _on_Exit_pressed():
	save()
	exit()

func _on_CharacterSearch_text_changed(new_text):
	purge_options()
	
	var req_char = get_closest_character_match(new_text)
	if req_char:
		$"%NotFound".visible = false
		$"%CharName".visible = true
		$"%CharName".text = req_char
		create_options_from_atlas(atlases[req_char])
		
		current_character = req_char
		
	else:
		$"%NotFound".visible = true
		$"%CharName".visible = false
		
#	--------------------------------------------------------------------------------------------- |
func _ready():
	pass

func _setup_finished():
	pass
	
	#$"%LibScript".atlases = atlases
	#$"%LibScript"._setup()
	
