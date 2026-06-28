extends Fighter

var buffers = {}

export (Dictionary) var objs_table
export (Dictionary) var vfx_table
var tweens = {
	
}

var realtick = 0
var lastpos
var charname = "Torment"

var free_array_place_cooldown = 0
var insight = false
var insight_eyes = []
var insight_eyes_spawned = 0
var insight_star_ticks = []

var terminus = false
var terminus_time = 0
var flight = false
export (Dictionary) var themes

var exhausted_moves = []

var skin = 0
var skin_enabled = true
export (SpriteFrames) var skin_sprites
export (Array) var skin_cosmetics
var skin_aura = true

export (Resource) var quotes

# ---------------------------------------------------------------------------------------------------------------
export (Resource) var vip

#func apply_style(style):
	#.apply_style(style)
	
	#skin = 0
	
	#var user_name = Network.pid_to_username(id)
	#if skin_enabled == true:
		#if [user_name, 1] in skins:			
			#if "Essence of Vevaro" in style.style_name:
				#skin = 1
				#charname = "Camila"
				
				#skin_aura = (not "[~]" in style.style_name)

#func apply_style(style):
	#.apply_style(style)
	
	#skin = 0
	
	#var username = Network.pid_to_username(id)
	#if username in vip.values:
		#if vip.values[username] != null:
			#var skins_owned = vip.values[username][0]
			#var title = vip.values[username][1]
			
			#if is_instance_valid($"%PrivelegeText") and self.is_ghost == false and title != "<NO-TITLE>":
				#$"%PrivelegeText".bbcode_text = "[center][" + title + "]\n" + username
				
			#if skin_enabled == true and style:		
				#if "Camila" in skins_owned and ("Essence of Vevaro" in style.style_name) or ("Mandate" in style.style_name):
					#charname = "Camila"
					#skin = 1	
					#skin_aura = not "[~]" in style.style_name

# ---------------------------------------------------------------------------------------------------------------
func choose_quote(quotes):
	var opp_name = self.opponent.get("charname")
	var found = false
	
	for n in quotes:
		if opp_name == n:
			return self.randi_choice(quotes[opp_name])
			found = true
	
	if found == false:
		return self.randi_choice(quotes._)

func toggle_terminus(choice):
	terminus = choice
	
#	--
func spawn_array(pos):
	#	EXISTS TO PREVENT CYCLIC PRELOADING
	var proj = self.get_owner().spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Array.tscn"), pos.x, 0, false, null, false)
	proj.set_grounded(true)
	proj.set_facing(self.randi_choice([-1, 1]))
	
func get_spike_arrays():
	var arrays = []
	
	for obj in self.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == self and obj.get("tag") == "Array":
			arrays.append(obj)
	
	return arrays
	
func get_furthest_spike_array():
	var furthest = self
	var furthest_dist = 0
	
	for obj in get_spike_arrays():
		if abs(obj.get_pos().x - self.get_pos().x) > furthest_dist:
			furthest = obj
			furthest_dist = abs(obj.get_pos().x - self.get_pos().x)
			
	return [furthest, furthest_dist]
	
func get_closest_array(dist: int):
	var closest = null
	var closest_dist = INF
	
	for obj in get_spike_arrays():
		var closest_pos = obj.get_pos()
		var length = abs(closest_pos.x - dist)
		
		if length < closest_dist:
			closest = obj
			closest_dist = length
	
	return closest
	
func get_most_threatening_star():
	var opos = self.opponent.get_pos()
	
	var closest = null
	var closest_dist = INF
	
	for obj in self.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == self and obj.get("tag") == "TerrorStar":
			var tpos = obj.get_pos()
			var length = Vector2(opos.x - tpos.x, opos.y - tpos.y).length()
			
			if length < closest_dist:
				closest = obj
				closest_dist = length
	
	return closest
	
# ------------------------------------------------------------------------------------------------ |
func afterimage():
	self.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Afterimage.tscn"), Vector2(0, -18), Vector2(self.get_facing_int(), 0))

func afterimage2(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)
	
# REAL 100% ARMOR SYSTEM WOW
func on_got_hit():
	.on_got_hit()
	
	"""
	if self.has_hyper_armor == true:
		self.has_hyper_armor = false
		var guard_broken = false
		var dmg = 0
		
		for ohbox in self.opponent.get_active_hitboxes():
			if guard_broken == false and ohbox.get("guard_break") == true and self.hurtbox.overlaps(ohbox):
				guard_broken = true
				dmg = ohbox.minimum_damage
				
		if self.combo_count < 1 and self.opponent.combo_count < 1:	
			if guard_broken == true:
				self.parry_effect(Vector2(0, -18), false)
				self.play_sound("Super3")
				
				self.hitlag_ticks = 0
				self.opponent.hitlag_ticks = 0
				self.global_hitlag(15)
					
				self.reset_momentum()
				self.opponent.reset_momentum()
				
				self.change_state("ThrowTech")
				self.opponent.change_state("ThrowTech")
				
				self.take_damage(dmg, 0, "1.0")
				
			else:
				self.current_state().interruptible_on_opponent_turn = true
				self.current_state().next_state_on_hold = false
				self.opponent.current_state().enable_hit_cancel()
				
				self.play_sound("Block")
				self.play_sound("Predict3")
	"""

func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS-Parry.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

# ---------------------------------------------------------------------------------------------------------------
func process_extra(extra):
	.process_extra(extra)
	
	buffers.targeted_array = extra.get("targeted_array")
	buffers.place_array = extra.get("place_array")
		
	if buffers.get("targeted_array") and extra.get("disable_array"):
		var array = self.obj_from_name(self.buffers.get("targeted_array"))
		
		if array:
			array.disable()
		
func _process(delta):
	._process(delta)
	
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	if terminus_time > 0: $"%Info".bbcode_text += "[color=#FF0044]Terminus: " + str(terminus_time) + "[/color]\n"
		
func init(pos = null):
	.init(pos)
	#MAX_HEALTH = 1666
	
	insight = false
	melee_attack_combo_scaling_applied = false
	
	.init(pos)
	$"%Stuff"._start()
		
func tick():
	.tick()
	$"%Stuff"._tick()
	
	realtick += 1
	
	#	--	COOL TEXT
	if current_tick == 1:
		if is_instance_valid($"%PrivelegeText") and self.is_ghost == false:
			if tweens.has("PrivelegeText"): tweens.PrivelegeText.kill()
			else: tweens.PrivelegeText = null
						
			$"%PrivelegeText".modulate = Color(1, 1, 1, 0.5)
				
			tweens.PrivelegeText = create_tween()
			tweens.PrivelegeText.tween_property($"%PrivelegeText", "modulate", Color(1, 1, 1, 0), 2)
	
	#	--	"COME HERE" STUFF
	if self.combo_count < 1 and self.stance == "ComeHere" and (not self.opponent.current_state().state_name in ["Burst", "OffensiveBurst", "DefensiveBurst", "Grabbed"]):
		self.change_stance_to("Normal")
		self.change_state("Wait")
	
	if self.game_over == true and current_state().state_name != "Taunt":
		if current_state().state_name == "Wait" or current_state().state_name == "Fall":
			spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Super.tscn"), Vector2(0, -18))
			super_effect(0)
			toggle_terminus(false)
			self.change_state("Taunt", {"Text": "", "Emote": self.randi_range(1, 4), "Skip": false})
	
	if self.combo_count < 1:
		exhausted_moves = []
			
	#	--	FREE ACTION ARRAY PLACEMENT
	if free_array_place_cooldown > 0 and (self.was_my_turn or self.opponent.was_my_turn):
		free_array_place_cooldown -= 1
	
	if self.turn_frames == 4 and buffers.get("place_array"):
		spawn_array(Vector2(self.get_pos().x + buffers.place_array, 0))
		
		spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Misc3.tscn"), Vector2(0, -18))
		
		free_array_place_cooldown = 3
		buffers.place_array = null
		
			
	#	--	INSIGHT STUFF
	if len(insight_star_ticks) > 0:
		for t in insight_star_ticks:
			var exclusions = ["Burst", "DefensiveBurst", "OffensiveBurst", "Parry"]
			var check = true
			
			for e in exclusions:
				if e in current_state().state_name:
					check = false
			
			if realtick == t and self.opponent.combo_count < 1 and check == true:
				spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/TerrorStar.tscn"), 0, -36, true, null, true)
				insight_star_ticks.remove("t")
	
	#	--	TERMINUS STUFF
	if terminus_time > 0 and terminus == true:
		terminus_time -= 1
		
		if terminus_time == 0:
			terminus = false
			
			self.spawn_particle_effect_relative(vfx_table.Flash2, Vector2(0, -18))
			self.play_sound("terminus_disable")
			self.play_sound("terminus_disable2")
	
	$"%TerminusFX".visible = terminus
	$"%TerminusWings".visible = terminus and skin == 0
	$"%TerminusWingsC".visible = terminus and skin == 1
	
	var offset_vel = Vector2((-int(self.get_vel().x)) * self.get_facing_int(), -int(self.get_vel().y))
	var lerp1 = lerp($"%TerminusWings".get_node("wings").position, Vector2(offset_vel.x * 2, offset_vel.y * 2), 0.2)
	var lerp2 = lerp($"%TerminusWings".get_node("wings2").position, Vector2(offset_vel.x * 3, offset_vel.y * 3), 0.2)
	$"%TerminusWings".get_node("wings").position = lerp1
	$"%TerminusWings".get_node("wings2").position = lerp2
	
	var lerp1C = lerp($"%TerminusWingsC".get_node("wings").position, Vector2(offset_vel.x * 2, offset_vel.y * 2), 0.2)
	var lerp2C = lerp($"%TerminusWingsC".get_node("wings2").position, Vector2(offset_vel.x * 3, offset_vel.y * 3), 0.2)
	$"%TerminusWingsC".get_node("wings").position = lerp1C
	$"%TerminusWingsC".get_node("wings2").position = lerp2C
	
	if self.state_machine.states_map["Wait"]:
		self.state_machine.states_map["Wait"].anim_name = "WaitT" if terminus else "Wait"
		
	if terminus == true:
		for obj in objs_map.values():
				if is_instance_valid(obj) and len(insight_eyes) > 0:
					if insight_eyes[len(insight_eyes) - 1] == obj.name:
						obj.activate()
	
	if terminus == true:
		if lastpos:
			if abs(float(self.get_pos().x) - float(lastpos.x)) > 30 and self.is_grounded() == true and self.opponent.combo_count < 1 and not "Parry" in self.current_state().state_name:
				var dist = self.current_di.x
				spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Spike.tscn"), (float(dist) * get_facing_int()) / 2, 0, true, null, true)
				lastpos = self.get_pos()
		else:
			lastpos = self.get_pos()
	
	#	--	SKIN STUFF
	$"%CamAura1".visible = ($"%Stuff".skin == "Camila" and $"%Stuff".skin_aura == true)
	$"%CamAura2".visible = ($"%Stuff".skin == "Camila" and $"%Stuff".skin_aura == true)
	$"%CamAura3".visible = ($"%Stuff".skin == "Camila" and $"%Stuff".skin_aura == true)
	
	$"%CamAura1".texture = self.sprite.frames.get_frame(sprite.animation, sprite.frame)
	
	if $"%Stuff".skin == "Camila":
		sprite.frames = skin_sprites
		
		if current_tick % 8 == 0 and self.is_grounded() == true:
			var p = randi_choice([skin_cosmetics[0], skin_cosmetics[1], skin_cosmetics[2], skin_cosmetics[3]])
			
			if p and $"%Stuff".skin_aura == true:
				self.spawn_particle_effect_relative(p, Vector2(0, 0))

		var main_scene = get_tree().get_current_scene()
		var buttons = main_scene.get_node("%P1ActionButtons") if self.id == 1 else main_scene.get_node("%P2ActionButtons")
		for action_button in buttons.buttons:
			if action_button.action_name == "terminus":
				action_button.get_node("%TextureRect").texture = preload("res://_NokTormentHellsaint/characters/hellsaint/skins/camila/icons/thsiconterminus_ca.png")
				action_button.action_title = "ASYMOLLYON"
				
		#	--
		var portrait
		match self.id:
			1:
				portrait = get_node_or_null("/root/Main/%P1Portrait")
			
			2:
				portrait = get_node_or_null("/root/Main/%P2Portrait")
				
		if portrait:
			portrait.texture = skin_cosmetics[4]

	#	--	EXTRA
	if self.current_state().type == 3 or terminus == true:
		afterimage2(Color(extra_color_2.r, extra_color_2.g, extra_color_2.b, 0.25), 0.1)
		
	#if self.turn_frames == 1 and self.is_ghost and buffers.get("targeted_array"):
		#buffers.targeted_array.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Misc3.tscn"), Vector2(0, 0))
