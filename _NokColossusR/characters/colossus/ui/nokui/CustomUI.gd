extends Node


export var _c_HP_Textures = 0
export var hp_under : Texture = null
export var hp_over : Texture = null
export var hp_progress : Texture = null
export var hp_armor : Texture = null
export var hp_projectile_armor : Texture = null
export var hp_trail : Texture = null
export var flip_hp_for_p2 : bool = true

export var _c_Burst_Textures = 0
export var burst_under : Texture = null
export var burst_over : Texture = null
export var burst_progress : Texture = null
export var flip_burst_for_p2 : bool = true

export var _c_Super_Textures = 0
export var mini_super_under : Texture = null
export var mini_super_over : Texture = null
export var mini_super_progress : Texture = null
export var flip_mini_super_for_p2 : bool = true

export var replay_super_under : Texture = null
export var replay_super_over : Texture = null
export var replay_super_progress : Texture = null
export var flip_replay_super_for_p2 : bool = true

export var _c_HP_Bar_Extra_Layer = 0
export var hp_layer_scene : PackedScene = null
export var put_extra_above_ghost_hp : bool = false
export var copy_extra_to_ghost_hp : bool = true

export var _c_Burst_Bar_Extra_Layer = 0
export var burst_layer_scene : PackedScene = null

export var _c_Super_Extra_Layers = 0
export var mini_super_layer_scene : PackedScene = null
export var hide_number_on_mini_super : bool = false
export var replay_super_layer_scene : PackedScene = null
export var hide_number_on_replay_super : bool = false

export var _c_Opponent_HP_Bar_Extra_Layer = 0
export var opponent_layer_scene : PackedScene = null
export var put_opponent_extra_above_ghost_hp : bool = false
export var copy_opponent_extra_to_ghost_hp : bool = true

export (int) var _c_cool_nok_stuff

const nodepaths = {
	"hp" :					{ 1:"/root/Main/%P1HealthBar",			2:"/root/Main/%P2HealthBar" },
	"hp_ghost" :			{ 1:"/root/Main/%P1GhostHealthBar",		2:"/root/Main/%P2GhostHealthBar" },
	"hp_trail" :			{ 1:"/root/Main/%P1HealthBarTrail",		2:"/root/Main/%P2HealthBarTrail" },
	"hp_ghost_trail" :		{ 1:"/root/Main/%P1GhostHealthBarTrail",2:"/root/Main/%P2GhostHealthBarTrail" },
	"opp_hp" :				{ 1:"/root/Main/%P2HealthBar",			2:"/root/Main/%P1HealthBar" },
	"opp_hp_ghost" :		{ 1:"/root/Main/%P2GhostHealthBar",		2:"/root/Main/%P1GhostHealthBar" },
	"burst" :				{ 1:"/root/Main/%P1BurstMeter",			2:"/root/Main/%P2BurstMeter" },
	"mini_super" :			{ 1:"/root/Main/%ActiveP1SuperMeter",	2:"/root/Main/%ActiveP2SuperMeter" },
	"mini_super_number" :	{ 1:"/root/Main/%ActiveP1NumSupers",	2:"/root/Main/%ActiveP2NumSupers" },
	"replay_super" :		{ 1:"/root/Main/%P1SuperMeter",			2:"/root/Main/%P2SuperMeter" },
	"replay_super_number" : { 1:"/root/Main/%P1NumSupers",			2:"/root/Main/%P2NumSupers" },
	
	"player_name" : { 1:"/root/Main/%P1Username",			2:"/root/Main/%P2Username" },
}



var host : Fighter = null

var custom_hp_bar : Node = null
var custom_opponent_bar : Node = null
var custom_burst_bar : Node = null
var custom_mini_super : Node = null
var custom_replay_super : Node = null

var ui_hp_bar : Node = null
var ui_opp_hp_bar : Node = null
var ui_ghost_hp : Node = null
var ui_hp_trail : Node = null
var ui_ghost_hp_trail : Node = null
var ui_burst_bar : Node = null
var ui_mini_super : Node = null
var ui_replay_super : Node = null
var ui_mini_super_number : Node = null
var ui_replay_super_number : Node = null


var default_hp_under = null
var default_hp_over = null
var default_hp_progress = null
var default_hp_trail = null
var default_burst_under = null
var default_burst_over = null
var default_burst_progress = null
var default_mini_super_under = null
var default_mini_super_over = null
var default_mini_super_progress = null
var default_replay_super_under = null
var default_replay_super_over = null
var default_replay_super_progress = null

var atlas_hp_under : AtlasTexture = null
var atlas_hp_over : AtlasTexture = null
var atlas_hp_progress : AtlasTexture = null
var atlas_hp_armor : AtlasTexture = null
var atlas_hp_projectile_armor : AtlasTexture = null
var atlas_hp_trail : AtlasTexture = null
var atlas_burst_under : AtlasTexture = null
var atlas_burst_over : AtlasTexture = null
var atlas_burst_progress : AtlasTexture = null
var atlas_mini_super_under : AtlasTexture = null
var atlas_mini_super_over : AtlasTexture = null
var atlas_mini_super_progress : AtlasTexture = null
var atlas_replay_super_under : AtlasTexture = null
var atlas_replay_super_over : AtlasTexture = null
var atlas_replay_super_progress : AtlasTexture = null



func _enter_tree():
	host = get_parent()
	if host.is_ghost:
		ui_hp_bar = get_node_or_null(nodepaths["hp_ghost"][host.id])
		ui_opp_hp_bar = get_node_or_null(nodepaths["opp_hp_ghost"][host.id])
		
		if is_instance_valid(ui_hp_bar):
			if hp_layer_scene != null and copy_extra_to_ghost_hp:
				custom_hp_bar = init_custom_layer(hp_layer_scene)
				custom_hp_bar.name = "TriUIExtraLayer"
				ui_hp_bar.add_child(custom_hp_bar)
				ui_hp_bar.move_child(custom_hp_bar, 0)
		if is_instance_valid(ui_opp_hp_bar):
			if opponent_layer_scene != null and copy_opponent_extra_to_ghost_hp:
				custom_opponent_bar = init_custom_layer(opponent_layer_scene)
				custom_opponent_bar.name = "TriUIOpponentLayer"
				ui_opp_hp_bar.add_child(custom_opponent_bar)
	
	if not host.is_ghost:
		ui_hp_bar = get_node_or_null(nodepaths["hp"][host.id])
		ui_opp_hp_bar = get_node_or_null(nodepaths["opp_hp"][host.id])
		ui_ghost_hp = get_node_or_null(nodepaths["hp_ghost"][host.id])
		ui_hp_trail = get_node_or_null(nodepaths["hp_trail"][host.id])
		ui_ghost_hp_trail = get_node_or_null(nodepaths["hp_ghost_trail"][host.id])
		ui_burst_bar = get_node_or_null(nodepaths["burst"][host.id])
		ui_mini_super = get_node_or_null(nodepaths["mini_super"][host.id])
		ui_replay_super = get_node_or_null(nodepaths["replay_super"][host.id])
		ui_mini_super_number = get_node_or_null(nodepaths["mini_super_number"][host.id])
		ui_replay_super_number = get_node_or_null(nodepaths["replay_super_number"][host.id])
		
		if hp_layer_scene != null and is_instance_valid(ui_hp_bar):
			custom_hp_bar = init_custom_layer(hp_layer_scene)
			ui_hp_bar.add_child(custom_hp_bar)
			if put_extra_above_ghost_hp:
				var target_index = ui_ghost_hp.get_index() + 1
				ui_hp_bar.move_child(custom_hp_bar, target_index)
			else:
				ui_hp_bar.move_child(custom_hp_bar, 0)
		if opponent_layer_scene != null and is_instance_valid(ui_opp_hp_bar):
			custom_opponent_bar = init_custom_layer(opponent_layer_scene)
			ui_opp_hp_bar.add_child(custom_opponent_bar)
			if put_opponent_extra_above_ghost_hp:
				pass
			else:
				var target_index = get_node(nodepaths["opp_hp_ghost"][host.id]).get_index()
				ui_opp_hp_bar.move_child(custom_opponent_bar, target_index)
		if burst_layer_scene != null and is_instance_valid(ui_burst_bar):
			custom_burst_bar = init_custom_layer(burst_layer_scene)
			ui_burst_bar.add_child(custom_burst_bar)
			ui_burst_bar.move_child(custom_burst_bar, 0)
		if mini_super_layer_scene != null and is_instance_valid(ui_mini_super):
			custom_mini_super = init_custom_layer(mini_super_layer_scene)
			ui_mini_super.add_child(custom_mini_super)
		if replay_super_layer_scene != null and is_instance_valid(ui_replay_super):
			custom_replay_super = init_custom_layer(replay_super_layer_scene)
			ui_replay_super.add_child(custom_replay_super)
		
		if hide_number_on_mini_super and is_instance_valid(ui_mini_super_number):
			ui_mini_super_number.visible = false
		if hide_number_on_replay_super and is_instance_valid(ui_replay_super_number):
			ui_replay_super_number.visible = false
		
		setup_texture_replacements()





func _process(delta):
	if is_instance_valid(host) and not host.is_ghost:
		if hide_number_on_mini_super:
			if is_instance_valid(ui_mini_super_number):
				ui_mini_super_number.visible = false
		if hide_number_on_replay_super:
			if is_instance_valid(ui_replay_super_number):
				ui_replay_super_number.visible = false
		var used_hp_progress_texture = null
		if host.has_armor():
			used_hp_progress_texture = atlas_hp_armor
		elif host.has_projectile_armor():
			used_hp_progress_texture = atlas_hp_projectile_armor
		else:
			used_hp_progress_texture = atlas_hp_progress	
		apply_textures_to_bar(ui_hp_bar, null, atlas_hp_over, used_hp_progress_texture)
		apply_textures_to_bar(ui_ghost_hp, null, atlas_hp_over, atlas_hp_progress)
		apply_textures_to_bar(ui_hp_trail, atlas_hp_under, null, atlas_hp_trail)
		apply_textures_to_bar(ui_ghost_hp_trail, null, null, atlas_hp_trail)
		apply_textures_to_bar(ui_burst_bar, atlas_burst_under, atlas_burst_over, atlas_burst_progress)
		apply_textures_to_bar(ui_mini_super, atlas_mini_super_under, atlas_mini_super_over, atlas_mini_super_progress)
		apply_textures_to_bar(ui_replay_super, atlas_replay_super_under, atlas_replay_super_over, atlas_replay_super_progress)

		#	--	ADDITIONAL RECOLOR SCRIPT
		#if ui_hp_bar: ui_hp_bar.material = host.sprite.material
		#if ui_burst_bar: ui_burst_bar.material = host.sprite.material
		#if ui_mini_super: ui_mini_super.material = host.sprite.material
		#if ui_replay_super: ui_replay_super.material = host.sprite.material

		#	--	COOL NOK STUFF
		
		var player_name = get_node_or_null(nodepaths["player_name"][host.id])
		
		if is_instance_valid(player_name):
			match host.id:
				1:
					player_name.rect_position = Vector2(10, 2)
				2:
					player_name.rect_position = Vector2(273, 2)


func apply_textures_to_bar(node, under, over, progress):
	if is_instance_valid(node):
		if under != null:
			node.texture_under = under
		if over != null:
			node.texture_over = over
		if progress != null:
			node.texture_progress = progress



func _exit_tree():
	if is_instance_valid(custom_hp_bar):
		custom_hp_bar.queue_free()
	if is_instance_valid(custom_burst_bar):
		custom_burst_bar.queue_free()
	if is_instance_valid(custom_mini_super):
		custom_mini_super.queue_free()
	if is_instance_valid(custom_replay_super):
		custom_replay_super.queue_free()
	if is_instance_valid(custom_opponent_bar):
		custom_opponent_bar.queue_free()
	
	if is_instance_valid(ui_mini_super_number):
		ui_mini_super_number.visible = true
	if is_instance_valid(ui_replay_super_number):
		ui_replay_super_number.visible = true
	
	if is_instance_valid(host) and not host.is_ghost:
		cleanup_texture_replacements()
	host = null





func setup_texture_replacements():
	if is_instance_valid(ui_hp_bar):
		default_hp_under = ui_hp_bar.texture_under
		default_hp_over = ui_hp_bar.texture_over
		default_hp_progress = ui_hp_bar.texture_progress
		if hp_under != null:
			atlas_hp_under = create_atlas_texture(hp_under, flip_hp_for_p2 and host.id==2)
		if hp_over != null:
			atlas_hp_over = create_atlas_texture(hp_over, flip_hp_for_p2 and host.id==2)
		if hp_progress != null:
			atlas_hp_progress = create_atlas_texture(hp_progress, flip_hp_for_p2 and host.id==2)
		if hp_armor != null:
			atlas_hp_armor = create_atlas_texture(hp_armor, flip_hp_for_p2 and host.id==2)
		if hp_projectile_armor != null:
			atlas_hp_projectile_armor = create_atlas_texture(hp_projectile_armor, flip_hp_for_p2 and host.id==2)
	if is_instance_valid(ui_hp_trail):
		default_hp_trail = ui_hp_trail.texture_progress
		if hp_trail != null:
			atlas_hp_trail = create_atlas_texture(hp_trail, flip_hp_for_p2 and host.id==2)
	if is_instance_valid(ui_burst_bar):
		default_burst_under = ui_burst_bar.texture_under
		default_burst_over = ui_burst_bar.texture_over
		default_burst_progress = ui_burst_bar.texture_progress
		if burst_under != null:
			atlas_burst_under = create_atlas_texture(burst_under, flip_burst_for_p2 and host.id==2)
		if burst_over != null:
			atlas_burst_over = create_atlas_texture(burst_over, flip_burst_for_p2 and host.id==2)
		if burst_progress != null:
			atlas_burst_progress = create_atlas_texture(burst_progress, flip_burst_for_p2 and host.id==2)
	if is_instance_valid(ui_mini_super):
		default_mini_super_under = ui_mini_super.texture_under
		default_mini_super_over = ui_mini_super.texture_over
		default_mini_super_progress = ui_mini_super.texture_progress
		if mini_super_under != null:
			atlas_mini_super_under = create_atlas_texture(mini_super_under, flip_mini_super_for_p2 and host.id==2)
		if mini_super_over != null:
			atlas_mini_super_over = create_atlas_texture(mini_super_over, flip_mini_super_for_p2 and host.id==2)
		if mini_super_progress != null:
			atlas_mini_super_progress = create_atlas_texture(mini_super_progress, flip_mini_super_for_p2 and host.id==2)
	if is_instance_valid(ui_replay_super):
		default_replay_super_under = ui_replay_super.texture_under
		default_replay_super_over = ui_replay_super.texture_over
		default_replay_super_progress = ui_replay_super.texture_progress
		if replay_super_under != null:
			atlas_replay_super_under = create_atlas_texture(replay_super_under, flip_replay_super_for_p2 and host.id==2)
		if replay_super_over != null:
			atlas_replay_super_over = create_atlas_texture(replay_super_over, flip_replay_super_for_p2 and host.id==2)
		if replay_super_progress != null:
			atlas_replay_super_progress = create_atlas_texture(replay_super_progress, flip_replay_super_for_p2 and host.id==2)





func cleanup_texture_replacements():
	if is_instance_valid(ui_hp_bar):
		ui_hp_bar.texture_under = default_hp_under
		ui_hp_bar.texture_over = default_hp_over
		ui_hp_bar.texture_progress = default_hp_progress
	if is_instance_valid(ui_hp_trail):
		ui_hp_trail.texture_under = null
		ui_hp_trail.texture_progress = default_hp_trail
	if is_instance_valid(ui_ghost_hp):
		ui_ghost_hp.texture_under = default_hp_under
		ui_ghost_hp.texture_over = default_hp_over
		ui_ghost_hp.texture_progress = default_hp_progress
	if is_instance_valid(ui_ghost_hp_trail):
		ui_ghost_hp_trail.texture_progress = default_hp_trail
	if is_instance_valid(ui_burst_bar):
		ui_burst_bar.texture_under = default_burst_under
		ui_burst_bar.texture_over = default_burst_over
		ui_burst_bar.texture_progress = default_burst_progress
	if is_instance_valid(ui_mini_super):
		ui_mini_super.texture_under = default_mini_super_under
		ui_mini_super.texture_over = default_mini_super_over
		ui_mini_super.texture_progress = default_mini_super_progress
	if is_instance_valid(ui_replay_super):
		ui_replay_super.texture_under = default_replay_super_under
		ui_replay_super.texture_over = default_replay_super_over
		ui_replay_super.texture_progress = default_replay_super_progress





func create_atlas_texture(source_tex : Texture, flip : bool = false) -> AtlasTexture:
	var result : AtlasTexture = AtlasTexture.new()
	result.atlas = source_tex
	result.flags = AtlasTexture.FLAG_MIRRORED_REPEAT
	result.region.size.x = source_tex.get_width()
	result.region.size.y = source_tex.get_height()
	if flip:
		result.region.position.x = result.region.size.x
	return result


func init_custom_layer(scene : PackedScene) -> Node:
	var custom_layer = scene.instance()
	if custom_layer.has_method("set_fighter"):
		custom_layer.set_fighter(host)
	custom_layer.name = "TriUIExtraLayer"
	if custom_layer is Control:
		custom_layer.anchor_top = 0
		custom_layer.anchor_left = 0
		custom_layer.anchor_bottom = 1
		custom_layer.anchor_right = 1
		custom_layer.margin_top = 0
		custom_layer.margin_left = 0
		custom_layer.margin_bottom = 0
		custom_layer.margin_right = 0
	return custom_layer
