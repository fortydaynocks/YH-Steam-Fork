extends Node

# ===========NOK SKIN STYLE VARS===============
var player_name = ""
var initialized = false
var skin_on = false
var character_name = "Ninja"
var connected = false
var vip = "res://_NokHekkenslib/VIP.tres"

onready var base_button_target = get_node_or_null(
	"/root/Main/UILayer/CustomizationScreen/SeeOn")
var skin_toggle = get_node_or_null(
	"/root/Main/UILayer/CustomizationScreen/SeeOn/Skin_Toggle")
onready var plus_button_target = get_node_or_null(
	"/root/Main/UILayer/CustomizationScreen/AuraEditor/HBoxContainer5")
onready var custom_menu = get_node_or_null(
	"/root/Main/UILayer/CustomizationScreen")
onready var customize_button = get_node_or_null(
	"/root/Main/%CustomizeButton");
var skin_toggle_plus = get_node_or_null(
	"/root/Main/UILayer/CustomizationScreen/AuraEditor/HBoxContainer5/Skin_Toggle")

const friendly_name = "HKLB_SKIN_HANDLE"
const SKIN_DATA = {
	"Betrayer": {
		"base_tres": "res://_NokBetrayer/characters/betrayer/resources/BT-SF.tres",
		"skin_tres": "res://_NokBetrayer/characters/betrayer/skins/munanyou/BT-SF-Munanyou.tres",
		"port_2_anim_name": "slayingmight",
		"port_2_frame": 5,
	},
	
	"Shin Goren": {
		"base_tres": "res://_NokGorenShin/characters/shingoren/resources/SG-SF.tres",
		"skin_tres": "res://_NokGorenShin/characters/shingoren/skins/akuma/SG-SF-AK.tres",
		"port_2_anim_name": "blasttrigger",
		"port_2_frame": 3,
	},
	
#	"Character Name [Top Node]": {
#		"base_tres": "path to base sprites tres file",
#		"skin_tres": "path to skin sprites tres file",
#		"port_2_anim_name": "sprite for bottom portrait",
#		"port_2_frame": which sprite frame for bottom portrait,
#	},
	
}
#============================================

func _ready():
	var existing = get_tree().get_nodes_in_group(friendly_name)
	if existing.size() > 0:
		queue_free()
		return
	
	add_to_group(friendly_name)
	if customize_button:
		customize_button.connect("pressed", self, "loaded")

func _physics_process(delta):
	if !initialized:
		initialize()
	if !connected:
		connect_the_button()

func initialize():
	var button_exists = null
	if has_style_editor_plus():
		button_exists = skin_toggle_plus
	else:
		button_exists = skin_toggle
	
	if button_exists:
		initialized = true
	else:
		add_skin_button()

func update_skin_base():
	if not skin_toggle: return
	skin_toggle.visible = false
	if not SKIN_DATA.has(character_name): return
	if is_in_vip_list():
		var node = [custom_menu.get_node_or_null("MovingSprite"), 
		custom_menu.get_node_or_null("StaticSprite")]
		if null in node: return
		skin_toggle.visible = true
		var port_2_anim_name = "Wait"
		var port_2_frame = 0
		var idle_sprite = null
		var attack_sprite = null
		var skin_tres = null
		var base_tres = null
		var data = SKIN_DATA[character_name]
		
		base_tres = load(data["base_tres"])
		skin_tres = load(data["skin_tres"])
		port_2_anim_name = data["port_2_anim_name"]
		port_2_frame = data["port_2_frame"]
		
		if not skin_tres or not base_tres: return
		
		if skin_on:
				idle_sprite = skin_tres.get_frame("Wait", 0)
				attack_sprite = skin_tres.get_frame(
					port_2_anim_name,
					port_2_frame)
		else:
				idle_sprite = base_tres.get_frame("Wait", 0)
				attack_sprite = base_tres.get_frame(
					port_2_anim_name, 
					port_2_frame)
		
		node[0].texture = attack_sprite
		node[1].texture = idle_sprite

func update_skin_plus():
	var v_sep = get_node_or_null(
	"/root/Main/UILayer/CustomizationScreen/AuraEditor/HBoxContainer5/VSeparator2")
	if v_sep:
		v_sep.hide()
	if not skin_toggle_plus: return
	skin_toggle_plus.visible = false
	if not SKIN_DATA.has(character_name): return
	if is_in_vip_list():
		skin_toggle_plus.visible = true
		if v_sep:
			v_sep.show()
		var skin_tres = null
		var base_tres = null
		var data = SKIN_DATA[character_name]
		
		base_tres = load(data["base_tres"])
		skin_tres = load(data["skin_tres"])
		
		if not skin_tres or not base_tres: return
		
		if skin_on:
			custom_menu.char_sprite_frames = skin_tres
		else:
			custom_menu.char_sprite_frames = base_tres
		call_deferred("update_tres")

func update_skin():
	if not custom_menu:
		return
	
	if has_style_editor_plus():
		update_skin_plus()
	else:
		update_skin_base()

func skin_toggled(pressed):
	skin_on = pressed
	call_deferred("update_skin")

func on_character_button_pressed(button):
	character_name = get_char_name(button)
	call_deferred("update_skin")

func update_tres():
	if custom_menu:
		custom_menu.populate_anims()
		custom_menu.set_to_idle()

func add_skin_button():
	var button = CheckButton.new()
	button.name = "Skin_Toggle"
	button.text = "Toggle Skin"
	button.visible = false
	button.set_tooltip("`Mandate` must be anywhere\n in the Style Name")
	if not has_style_editor_plus():
		if not base_button_target: return
		base_button_target.add_child(button)
		button.call_deferred("set_position", Vector2(-1, -13))
		skin_toggle = button
	else:
		if not plus_button_target: return
		plus_button_target.add_child(button)
		skin_toggle_plus = button
	button.call_deferred("set_size", Vector2(76, 12))
	button.connect("toggled", self, "skin_toggled")

func connect_the_button():
	var char_but_cont = null
	if has_style_editor_plus():
		char_but_cont = get_node_or_null(
		"/root/Main/UILayer/CustomizationScreen/AuraEditor/VBoxContainer2/Main/Tabs/Char/ScrollContainer2/VBoxContainer/Character Select/CharacterButtonContainer"
	)
	else:
		char_but_cont = get_node_or_null(
		"/root/Main/UILayer/CustomizationScreen/ScrollContainer/CharacterButtonContainer"
	)
	if not char_but_cont:
		return
	for char_but in char_but_cont.get_children():
		if not char_but.is_connected("pressed", self, "on_character_button_pressed"):
			char_but.connect("pressed", self, "on_character_button_pressed",[char_but])
		else:
			connected = true

func loaded():
	if custom_menu:
		player_name = custom_menu._current_username()

func is_in_vip_list():
	if not ResourceLoader.exists(vip): 
		return false
	
	var VIPs = ResourceLoader.load(vip).list
	
	if not VIPs.has(character_name): 
		return false
	
	return player_name in VIPs[character_name]

func get_char_name(button):
	var new_name = button.text
	var filter = new_name.rfind("__")
	if filter != -1:
		filter += 2
		new_name = new_name.right(filter)
	print("Loading ",new_name, " in style menu")
	return new_name

func has_style_editor_plus():
	return ResourceLoader.exists(
	"res://AdvancedStyleMenu/ModMain.gd")
	
