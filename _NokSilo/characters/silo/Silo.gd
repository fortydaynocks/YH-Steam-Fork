extends Fighter

export (Dictionary) var objs_table
export (Dictionary) var vfx_table
var tweens = {
	
}
export (Resource) var vip

var charname = "Silo"
var run = 1

var stress = 0.5
var last_stress = 0.5
var high_stress = 0.8
var low_stress = 0.2

var insanity = false

var portalspikes = 0
var portalspike_frame = 0
var portalspike_interval = 4
var portalspike_cooldown = 0

var grabbyhands = 0
var grabbyhands_frame = 0
var grabbyhands_interval = 6

var eyes = []
var torturemarks = []
var sustainers = []
var bloodflowers = []
var monoliths = []
var monoliths_created_in_combo = [0, 1]

var eye_distance = 200
var eye_deadzone = 50

var bloodflower_range = 60
var buffer_harvest = false

# ---------------------------------------------------------------------------------------------------------------
func apply_style(style):
	.apply_style(style)
	
	var username = Network.pid_to_username(id)
	if username in vip.VIPs:
		var owned_skins = vip.VIPs[username][0]
		var title = vip.VIPs[username][1]
		
		#	--	SKIN
		if vip.skin_enabled == true:
			for available_skin in vip.skins.keys():
				var required_style_name = vip.skins[available_skin]
				
				if available_skin in owned_skins and required_style_name in style.style_name:
					vip.skin = available_skin
		
		#	--	TITLE
		if is_instance_valid($"%PrivelegeText") and self.is_ghost == false:
			$"%PrivelegeText".bbcode_text = "[center][" + title + "]\n" + username
		
# ---------------------------------------------------------------------------------------------------------------
func gain_super_meter(amount, stale_amount = "1.0"):
	if stress >= high_stress:
		.gain_super_meter(amount * 0.85, stale_amount)
		
	elif stress <= low_stress:
		.gain_super_meter(amount * 1.15, stale_amount)
		
	else:
		.gain_super_meter(amount, stale_amount)
		
func on_got_hit():
	.on_got_hit()
	
	stress += 0.01
		
#	--
func process_extra(extra):
	.process_extra(extra)

#	--	FLOWER HARVESTING
	if extra.has("harvest"):
		var closest_bloodflower = get_closest_flower(self, bloodflower_range)
		
		if is_instance_valid(closest_bloodflower):
			if extra.harvest == true and closest_bloodflower.can_harvest == true:
				buffer_harvest = true
#	--

func apply_torture(obj):
	var already_tortured = false
	
	for mark in torturemarks:
		if is_instance_valid(self.objs_map.get(mark)):
			var mark_obj = self.objs_map[mark]
			if mark_obj.victim == obj.obj_name:
				already_tortured = true
	
	if already_tortured == false:
		var tmark = self.spawn_object(self.objs_table.TortureMark, 0, 0, false, null, false)
		tmark.victim = obj.obj_name
		self.torturemarks.append(tmark.obj_name)

		self.play_sound("MarkApplied")
		
	
func cease_torture():
	var preference
	var preferred_victim
	
	for mark in torturemarks:
		if is_instance_valid(self.objs_map.get(mark)):
			var mark_obj = self.objs_map[mark]
	
			if mark_obj.disabled != true:
				if mark_obj.victim == self.opponent.obj_name:
					if preference == null:
						preference = mark
						preferred_victim = mark_obj.victim
					
				else:
					preference = mark
					preferred_victim = mark_obj.victim
	
	if is_instance_valid(self.objs_map.get(preference)):
		self.objs_map[preference].disable()
	else:
		if len(torturemarks) > 0:
			if is_instance_valid(self.objs_map.get(torturemarks[0])): 
				self.objs_map[torturemarks[0]].disable()
		
func get_closest_flower(obj, max_distance = -1):
	var last_closest_flower = null
	var last_closest_flower_distance = 0
	
	for flower in bloodflowers:
		var flower_obj = self.objs_map[flower]
		
		if is_instance_valid(flower_obj):
			var distance2flower = abs(float(flower_obj.get_pos().x) - float(obj.get_pos().x))
			
			if last_closest_flower == null:
				last_closest_flower = flower
				last_closest_flower_distance = distance2flower
					
			else:
				var last_flower_obj = self.objs_map[last_closest_flower]
				if is_instance_valid(last_flower_obj):
					var distance2lastflower = abs(float(last_flower_obj.get_pos().x) - float(obj.get_pos().x))

					if distance2flower < distance2lastflower:
						last_closest_flower = flower
						last_closest_flower_distance = distance2flower
						
	if last_closest_flower_distance > max_distance and max_distance != -1:
		last_closest_flower = null
						
	if last_closest_flower != null:
		return self.objs_map[last_closest_flower]
	else:
		return null
#	--
func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)

func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokSilo/characters/silo/effects/parry/SL-Parry.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

# ---------------------------------------------------------------------------------------------------------------
func sin_voiceline(quote_set = null):
	if ReplayManager.resimulating == true: return
	
	var opp_name = self.opponent.get("charname")
	var quote
	
	for n in quote_set:
		if opp_name == n:
			quote = self.randi_choice(quote_set[opp_name])
	
	if not quote: quote = self.randi_choice(quote_set["_"])
	if is_instance_valid($"%Emote"):
		if tweens.has("emote_tween"): emote_tween.kill()
		else: emote_tween = null
		
		$"%Emote".bbcode_text = "[center]" + quote
		$"%Emote".percent_visible = float(0)
		$"%Emote".modulate = Color(1, 1, 1, 1)
		
		var t = len(quote) * 0.025
		
		if vip.skin == "Sinestrosa":
			vip.soundbytes_left = round(len(quote) * 0.75)
		
		emote_tween = create_tween()
		emote_tween.tween_property($"%Emote", "percent_visible", float(1), t)
		emote_tween.tween_property($"%Emote", "modulate", Color(1, 1, 1, 0), t + 0.25)
	

# ---------------------------------------------------------------------------------------------------------------
func init(pos = null):
	MAX_HEALTH = 1200
	melee_attack_combo_scaling_applied = false
	
	vip.host = self
	.init(pos)
	
func tick():
	.tick()
	
	var pos = self.get_pos()
	var opos = self.opponent.get_pos()
	var vel = self.get_vel()
	var ovel = self.opponent.get_vel()
	
	#	--	MONOLITH COMBO LIMIT
	if self.combo_count <= 0:
		monoliths_created_in_combo[0] = 0
	
	#	--	PORTAL SPIKES
	if portalspikes > 0:
		if portalspike_frame >= portalspike_interval:
			portalspike_frame = 0
			portalspikes -= 1
			
			self.spawn_object(objs_table.PortalSpike, float(opos.x), float(opos.y) - 18, false, null, false)
			
			if portalspikes <= 0:
				portalspike_cooldown = 15
		else:
			portalspike_frame += 1
		
	else:
		portalspike_frame = 0
		
		if portalspike_cooldown > 0:
			portalspike_cooldown -= 1
			
	#	--	GRABBY HANDS
	if grabbyhands > 0:
		if grabbyhands_frame >= grabbyhands_interval:
			grabbyhands_frame = 0
			grabbyhands -= 1
			
			self.spawn_object(objs_table.WitheringHand, float(opos.x), float(opos.y) - 18, false, null, false)
		else:
			grabbyhands_frame += 1
		
	else:
		grabbyhands_frame = 0
		
	#	--	BLOODFLOWER HARVEST PROPERTIES
	for flower in bloodflowers:
		var flower_obj = self.objs_map[flower]
		
		if is_instance_valid(flower_obj):
			flower_obj.can_harvest = false
			
	var closest_bloodflower = get_closest_flower(self, bloodflower_range)
	if is_instance_valid(closest_bloodflower):
		if closest_bloodflower.ripe == true:
			closest_bloodflower.can_harvest = true

		if buffer_harvest == true:
			self.spawn_particle_effect(vfx_table.Harvest, Vector2(float(closest_bloodflower.get_pos().x), float(closest_bloodflower.get_pos().y - 22)))
			
			for eye in eyes:
				var eye_obj = self.objs_map[eye]
				
				if is_instance_valid(eye_obj) and is_instance_valid(eye_obj.target):
					if eye_obj.target.obj_name == closest_bloodflower.obj_name:
						eye_obj.change_state("Close")
				
			self.play_sound("Harvest")
			self.play_sound("Harvest2")
				
			self.stress -= 0.15
				
			closest_bloodflower.kill = true	
			self.buffer_harvest = false
			
	#	--	STRESS FUNCTIONALITY
	stress = clamp(stress, 0, 1)
	
	if is_instance_valid($"%StressIndicator"):
		$"%StressIndicator".visible = self.is_ghost
		
		var bar_progress = -17 + (34 * stress)
		$"%StressIndicator".get_node("Bar").offset.x = lerp($"%StressIndicator".get_node("Bar").offset.x, bar_progress, 0.25)
		$"%StressIndicator".get_node("Text").text = "Stress: " + str(stress * 100) + "%"
		
	if stress >= high_stress:
		self.damage_taken_modifier = "1.15"
		self.global_damage_modifier = "1.15"
		
		if last_stress < high_stress:
			self.play_sound("StressHigh")
			self.play_sound("StressHigh2")
			
			self.spawn_particle_effect_relative(vfx_table.Harvest, Vector2(0, -12))
			self.screen_bump(Vector2(0, 0), 2, 0.25)
			
	elif stress <= low_stress:
		self.damage_taken_modifier = "0.85"
		self.global_damage_modifier = "0.85"
		
		if last_stress > low_stress:
			self.play_sound("StressLow")
			
			self.spawn_particle_effect_relative(vfx_table.Harvest2, Vector2(0, -12))
		
	else:
		self.damage_taken_modifier = "1.0"
		self.global_damage_modifier = "1.0"
		
	last_stress = stress
	
	#	--
	$"%InsanityAura".visible = insanity
	$"%InsanityAura2".visible = insanity
	$"%InsanityAura3".visible = insanity
	$"%InsanityAura".texture = self.sprite.frames.get_frame(self.sprite.animation, self.sprite.frame)

	#	--	PRIVLEGES ---
	if current_tick == 1:
		if is_instance_valid($"%PrivelegeText") and self.is_ghost == false:
			if tweens.has("PrivelegeText"): tweens.PrivelegeText.kill()
			else: tweens.PrivelegeText = null
						
			$"%PrivelegeText".modulate = Color(1, 1, 1, 0.5)
				
			tweens.PrivelegeText = create_tween()
			tweens.PrivelegeText.tween_property($"%PrivelegeText", "modulate", Color(1, 1, 1, 0), 2)

	if vip.skin in ["Sinestrosa", "SinWings"]:
		if is_instance_valid($"%SinWings"):
			$"%SinWings".visible = (vip.show_wings == true)
			$"%SinWings".material = self.sprite.material
			
			var offset_vel = Vector2((-int(self.get_vel().x)) * self.get_facing_int(), -int(self.get_vel().y))
			$"%SinWings".position = lerp($"%SinWings".position, Vector2(offset_vel.x * 2, (offset_vel.y * 2) - 18), 0.2)
			
			
			
		if vip.skin == "Sinestrosa":
			self.sprite.frames = vip.skin_sprites
			
			if vip.soundbytes_left > 0 and current_tick % 2 == 0:
				self.play_sound("Sin-Soundbyte")
				vip.soundbytes_left -= 1
	
	else:
		if is_instance_valid($"%SinWings"):
			$"%SinWings".visible = false
