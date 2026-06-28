extends Fighter

export var _c_Gentleman = 0
export (Dictionary) var objs_table = {}
export (Dictionary) var vfx_table = {}
export (Dictionary) var colors_table = {}

var screen_pos = Vector2(0, 0)

var charname = "Gentleman"
export (Resource) var skins
var money = 0

var last_supers_available

var chairs = {}
var can_recline = 0
var recline_threshold = 0
var recline_exclusions = [
	"Start", "ParrySuper", "ParryHigh", "ParryAfterWhiff", "ParryAuto", "ParryLow", "ParryAir",
	"Roll", "Burst", "DefensiveBurst", "OffensiveBurst", "Knockdown", "HardKnockdown", "Getup",
	"TechRoll", "InstantCancel", "WhiffInstantCancel", "HurtDizzy", "WallSlam", "HurtAerial",
	"HurtGrounded", "Grabbed", "G"
]

enum itemType {
	Temporary,
	Permanent,
	Offsale
}
var items = {
	"Brass Knuckle": {
		"Name": "Brass Knuckle",
		"Price": 75,
		"Owned": 0,
		"Max": 3,
		"Type": itemType.Temporary,
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-brassknuckle.png"),
		"Tooltip": "Deal extra damage on hit.",
		
		"Damage": 0,
		"PassedTurns": 0
		},
	"Money Shot": {
		"Name": "Money Shot",
		"Price": 50,
		"Owned": 0,
		"Max": 3,
		"Type": itemType.Temporary,
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-moneyshot.png"),
		"Tooltip": "+10% meter gain per. Use as ammo for Countermeasures.",
		
		},
	"Iron Shield": {
		"Name": "Iron Shield",
		"Price": 100,
		"Owned": 0,
		"Max": 1,
		"Type": itemType.Temporary,
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-ironshield.png"),
		"Tooltip": "Parry attacks to gain significant block advantage.",
		
		},
	"Agent License": {
		"Name": "Agent License",
		"Price": 75,
		"Owned": 0,
		"Max": 3,
		"Type": itemType.Temporary,
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-agentlicense.png"),
		"Tooltip": "Call in an Agent to aid your offense.",
		
		},
	"Pocket Knife": {
		"Name": "Pocket Knife",
		"Price": 75,
		"Owned": 0,
		"Max": 3,
		"Type": itemType.Temporary,
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-pocketknife.png"),
		"Tooltip": "Engage the opponent with ligthtning fast slashes.",
		
		},
	"Misc. item 3": {
		"Name": "Misc. item 3",
		"Price": 0,
		"Owned": 0,
		"Max": 2,
		"Type": itemType.Temporary,
		"Icon": preload("res://ui/ActionSelector/StateIcons/taunt.png"),
		"Tooltip": "[unfinished]",
		
		},
	"Tea Set": {
		"Name": "Tea Set",
		"Price": 50,
		"Owned": 0,
		"Max": 3,
		"Type": itemType.Permanent,
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-teaset.png"),
		"Tooltip": "Drink to gain health or throw as a projectile.",
		
		},
	"Countermeasures": {
		"Name": "Countermeasures",
		"Price": 200,
		"Owned": 0,
		"Max": 2,
		"Type": itemType.Permanent,
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-countermeasures.png"),
		"Tooltip": "Shoot the opponent with your gun.",
		
		},
	"Blackridge": {
		"Name": "Blackridge",
		"Price": 400,
		"Owned": 0,
		"Max": 1,
		"Type": itemType.Permanent, 
		"Icon": preload("res://_NokGentleman/characters/gentleman/ui/gmui_item-blackridge.png"),
		"Tooltip": "Traverse the stage rapidly with your prized motorcycle.",
		
		},
}
var items_in_store = {}

var agents = {}

#	-------------------------------------------------------------------------------------------------------
func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokGentleman/characters/gentleman/effects/GM-Parry.tscn")
		pos = Vector2(float(self.get_pos().x), float(self.get_pos().y) - 18)
	
	var obj = ._spawn_particle_effect(particle_effect, pos, dir)
	
	return obj
	
func process_extra(extra):
	.process_extra(extra)
	
	can_recline = extra.recline
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	var scaled_dmg = round(self.opponent.combo_stale_damage(hitbox.damage) * 0.75)
	money += scaled_dmg
	
	#	--	BRASS KNUCKLES
	activate_item("Brass Knuckle", hitbox)
	
func on_parried():
	.on_parried()
	
	if self.opponent.got_parried == true:
		money += 300
						
	else:
		money += 150
		
func gain_super_meter(amount, stale_amount = "1.0"):
	.gain_super_meter(amount * (1 + (0.1 * items["Money Shot"].Owned)), stale_amount)
		
#	-------------------------------------------------------------------------------------------------------
func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)

func shuffle_items_in_store(count = 3):
	items_in_store = {}
	var item_keys = items.keys()
	
	#	--
	var temp_items_left = 0
	
	for item_key in items:
		var item_value = items[item_key]
		
		if item_value.Type == itemType.Temporary and item_value.Owned < item_value.Max:
			temp_items_left += 1
	
	while len(items_in_store) < clamp(count, 0, temp_items_left):
		var temp_item = items[item_keys[self.randi_range(1, len(items)) - 1]]
		
		if not (temp_item in items_in_store):
			if temp_item.Type == itemType.Temporary and temp_item.Owned < temp_item.Max:
				items_in_store[temp_item.Name] = temp_item
	
	#	--
	for perm_item_key in items:
		var perm_item_value = items[perm_item_key]
		
		if perm_item_value.Type == itemType.Permanent and perm_item_value.Owned < perm_item_value.Max:
			items_in_store[perm_item_value.Name] = perm_item_value
	
func has_item(item_name, quantity = 1):
	if items[item_name]:
		if items[item_name].Owned >= quantity:
			return true
	
	return false
	
func has_items(items_array):
	var query = {}
	var satisfied = true
	
	for item in items_array:
		if item in query:
			query[item] += 1
		else:
			query[item] = 1
			
	for query_item in query.keys():
		if query_item in items:
			if items[query_item].Owned < query[query_item]:
				satisfied = false
	
	return satisfied
	
func use_item(item_name):
	if items[item_name]:
		if items[item_name].Owned > 0:
			items[item_name].Owned -= 1
		
	update_item_icons()
	shuffle_items_in_store(3)

func activate_item(item_name, extra1 = null, extra2 = null, extra3 = null):
	if item_name == "Brass Knuckle":
		#	extra1 = hitbox
		if items["Brass Knuckle"].Owned > 0 and (not "IgnoreBrassKnuckle" in extra1.misc_data):
			if items["Brass Knuckle"].Damage == 0:
				items["Brass Knuckle"].Damage = round(self.opponent.combo_stale_damage(extra1.damage) * 0.75)
				self.play_sound("BrassKnuckle2")
				
func grant_random_item(temporary = true, permanent = false):
	var pool = []
	
	for item_key in items:
		var item = items[item_key]
		
		if item.Owned < item.Max:
			if (item.Type == itemType.Temporary and temporary == true) or (item.Type == itemType.Permanent and permanent == true):
				pool.append(item)
			
	self.randi_choice(pool).Owned += 1
	update_item_icons()

func create_icon(item):
	if is_instance_valid($"%ItemIconBase"):
		var new_icon = $"%ItemIconBase".duplicate(true)
		$"%ItemIcons".add_child(new_icon)
		new_icon.get_node("Particle").texture = item.Icon
		new_icon.visible = true

func update_item_icons():
	if (not is_ghost) and (not ReplayManager.resimulating): return
	
	if is_instance_valid($"%ItemIcons"):
		for child in $"%ItemIcons".get_children():
			child.queue_free()
				
		for item_key in items:
			var item_value = items[item_key]
				
			for count in item_value.Owned:
				create_icon(item_value)

func get_nearest_chair(forced = false):
	var nearest_chair = [null, INF]
	
	for chair in self.objs_map.values():
		if is_instance_valid(chair) and chair.current_state():
			if chair.get_owner() == self and chair.disabled != true and chair.get("isgentlemanchair"):
				var dist2chair = int(distance_to(chair))
				if dist2chair < nearest_chair[1]:
					nearest_chair = [chair.obj_name, dist2chair]
					
	return nearest_chair

#	-------------------------------------------------------------------------------------------------------
func on_state_started(state):
	.on_state_started(state)
	
#func can_block_cancel():
	#return false

#	-------------------------------------------------------------------------------------------------------
func _init():
	._init()
	
	self.melee_attack_combo_scaling_applied = false
	last_supers_available = self.supers_available
	money = 100
	
	items["Countermeasures"].Owned = 1
	
	update_item_icons()

func tick():
	.tick()
	
	if self.infinite_resources:
		money = 50000
	
	#	--	CHAIR RECLINING
	if can_recline > 0 and self.opponent.combo_count <= 0 and self.current_state().get("recline_state") != true and (not "CannotRecline" in self.current_state().editor_description):
		var will_recline_in_chair = false
		for chair in self.objs_map.values():
			if is_instance_valid(chair) and chair.current_state():
				if chair.get_owner() == self and chair.disabled != true and chair.get("isgentlemanchair") and chair.current_state().current_tick >= 10 and self.current_state().current_tick >= can_recline:
					#	--
					var move_speed = Vector2(float(self.get_vel().x), float(self.get_vel().y)).length()
					if self.hurtbox.overlaps(chair.hurtbox) and move_speed >= recline_threshold and will_recline_in_chair == false:
						will_recline_in_chair = true
						
						chair.disable()
						
						self.change_state("reclinestartup")
						self.update_facing()
						
	#	--	ITEM STUFF
	shuffle_items_in_store(3)
	
	if self.game_tick == 1:	
		if self.infinite_resources:
			for item_key in items:
				var item_value = items[item_key]
			
				item_value.Owned = item_value.Max
	
	if self.game_tick > 1:	
		if last_supers_available != self.supers_available:
			money += 50
			
	last_supers_available = self.supers_available

	#	BRASS KNUCKLE
	if items["Brass Knuckle"].Damage > 0:
		items["Brass Knuckle"].PassedTurns += 1
		
		if items["Brass Knuckle"].Owned > 0:
			if items["Brass Knuckle"].PassedTurns >= 6:
				use_item("Brass Knuckle")
			
				self.opponent.take_damage(items["Brass Knuckle"].Damage)
				self.combo_count += 1
			
				self.play_sound("BrassKnuckle")
				self.spawn_particle_effect(vfx_table.HitBrassKnuckle, Vector2(float(self.opponent.get_pos().x), float(self.opponent.get_pos().y) - 18))
				self.screen_bump(Vector2(0, 0), 8, 0.25)
				self.global_hitlag(12)
				
				items["Brass Knuckle"].PassedTurns = 0
			
		else:
			items["Brass Knuckle"].Damage = 0
			items["Brass Knuckle"].PassedTurns = 0
		

	#	--	DISPLAYS
	$"%MoneyCount".visible = self.is_ghost
	$"%MoneyCount".text = "$" + str(money)
	
	$"%ItemIcons".visible = self.is_ghost
	if self.turn_frames == 1:
		update_item_icons()

