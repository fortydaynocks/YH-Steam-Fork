extends "res://modloader/MLMainHook.gd"

onready var menu_asset = preload("res://_NokHekkenslib/ui/HKLB-Menu.tscn")
onready var button_icon = preload("res://_NokHekkenslib/ui/hklb-ui-book.png")

var menu
var path_suffix = "/HKLB-Atlas.gd"
var data_directory = "user://hekkenslib.json"
var vip_list = "res://_NokHekkenslib/VIP.json"
var data_file

#	--
func retrieve_character_atlases():
	var character_list = Global.name_paths
	var found_atlases = {}
	
	for found_character in character_list:
		var char_name = found_character
		var char_path = character_list[found_character]
		
		var split_path = char_path.split("/")
		var possible_atlas = split_path[0] + "//" + split_path[2] + path_suffix
		
		if ResourceLoader.exists(possible_atlas):
			var atlas = ResourceLoader.load(possible_atlas)
			
			if atlas is GDScript:
				var atlas_script = atlas.new()
				found_atlases[char_name] = atlas_script.atlas
	
	return found_atlases
		
				
#	--
func add_button():
	var button: Button = self.addMainMenuButton("Hekkenslib")
	button.icon = button_icon
	button.connect("pressed", menu, "open_menu")
	
func open_menu():
	pass
	
func hklb_button_pressed():
	var options_layer = $"%OptionsContainer/.."
	
	if not options_layer.get_node("HKLB-Menu"):
		var menu = menu_asset.instance()
		options_layer.add_child(menu)
	
#	--
func _ready():
	._ready()
	
	pass
	
	#	--	GET CHARACTER ATLASES
	#var atlases = retrieve_character_atlases()
		
	#	--	CREATE MENU
	#if not menu:
		#menu = menu_asset.instance()
		#var container = get_node_or_null("%OptionsContainer/..")
		#if container: container.add_child(menu)
		
		#menu.visible = false
		#menu.atlases = atlases
		#menu.data_file = File.new()
		
		#add_button()
		#menu._setup_finished()
		#_setup_finished()
	
	#var main = get_node("/root/Main")
	#main.connect("game_started", self, "_on_game_started")
	
	#	--	UPDATING THE VIP LIST TO THE HEKKENSLIB LIST
	#var new_file = File.new()
	#new_file.open(data_directory, new_file.READ)
		
	#var json_data = parse_json(new_file.get_as_text()); if json_data == null:
		#new_file.store_string(JSON.print({}))
		#json_data = {}
		
	#var vip_file = File.new()
	#vip_file.open(vip_list, vip_file.READ)
	#var vip_json = parse_json(vip_file.get_as_text())
	#vip_file.close()
	
	#print("this is the VIP JSON list")
	#print(vip_json)
	
	#new_file.open(data_directory, new_file.WRITE)
	#json_data["VIP"] = vip_json if vip_json else {}
	#new_file.store_string(JSON.print(json_data, "	"))
	#new_file.close()
	
	#print("hi")
		
func _setup_finished():
	pass
	
func _on_game_started():
	pass
		

		
	
