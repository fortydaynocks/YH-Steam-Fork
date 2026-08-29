extends "res://modloader/MLMainHook.gd"

onready var menu_asset = preload("res://_NokHekkenslib/ui/HKLB-Menu.tscn")
onready var button_icon = preload("res://_NokHekkenslib/ui/hklb-ui-book.png")

var menu
var path_suffix = "/HKLB-Atlas.gd"
var data_directory = "user://hekkenslib.json"
var vip_list = "res://_NokHekkenslib/VIP.json"
var data_file

#	========================================================================== >		
func hklb_button_pressed():
	var options_layer = $"%OptionsContainer/.."
	
	if not options_layer.get_node_or_null("HKLB-Menu"):
		var menu = menu_asset.instance()
		options_layer.add_child(menu)
	
#	========================================================================== >		
func _ready():
	if not menu:
		menu = menu_asset.instance()
		var container = get_node_or_null("%OptionsContainer/..")
		if container: container.add_child(menu)
		
		menu.visible = false
		
		var button: Button = self.addMainMenuButton("Hekkenslib")
		button.icon = button_icon
		button.connect("pressed", menu, "open_menu")
	
	self.get_owner().connect("game_started", menu, "game_started", [], CONNECT_DEFERRED)
	
	#	==	COURTESY OF FURIOUS	============================================== >
	var hekken_skin_handle = load("res://_NokHekkenslib/scripts/HKLB-CustomStyle.gd").new()
	call_deferred("add_child", hekken_skin_handle)
	
	#	--	CREATE MENU
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
		

		
	
