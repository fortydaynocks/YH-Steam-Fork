extends Fighter
export (Resource) var stuff

var charname = "Colossus"
var fortitude = {
	"Value": 0,
	"Max": 200,
	"ArmorCost": 30,
	"AutoGain": 4,
	"AutoGainMax": 100,
	"WeaknessThreshold": 30,
	"WeaknessExtraDMG": 1.5,
	"WeaknessBlockFortitudeGiven": false,
}
var lordflame = {
	"Value": 0,
	"Max": 9,
	"Flamestain": 0,
	"BurnThreshold": 3,
}

var flamestain = {
	"Value": 0,
	"Max": 6,
	"Burning": false,
	"HasBurnedThisTurn": false,
	"BurnDamage": 4,
	"TurnLocked": false,
}

var hits_with_armor = {
	"Opponent": 0,
	"Projectile": 0,
	"DamageMultiplier": 0.4,
	"PlusFrames": 1,
}

var armor_broken_this_turn = false

var current_special_stance = "Sword"
var buffer_armor = false
var buffer_css = null
var buffer_conversions = 0

var buffers = {
	"quake": false,
	"blade": false,
}

var end_blade = null

# ---------------------------------------------------------------------------------------------------------------
func increment_flamestain(amount, can_burn = true, fx = true):
	if flamestain.TurnLocked == true: return
	
	flamestain.Value = clamp(flamestain.Value + amount, 0, flamestain.Max)
	
	if amount > 0 and fx == true:
		#self.play_sound("GainFlamestain")
		self._spawn_particle_effect(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameSwitch.tscn"), Vector2(self.opponent.get_pos().x, self.opponent.get_pos().y - 18))
	
	if flamestain.Value >= lordflame.BurnThreshold and can_burn == true:
		flamestain.Burning = true

func get_max_lordflames_possible():
	var super_amount = stepify(float(self.supers_available) + ((float(self.super_meter) / float(self.MAX_SUPER_METER))), 0.1)
	
	return floor(super_amount * 2)

func convert_lordflames(amount):
	amount = clamp(amount, 0, get_max_lordflames_possible())
	
	if amount > 0:
		self.screen_bump(Vector2(0, 0), 4, 0.1)
		self.play_sound("ConvertFlames")
		self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-ConvertFlame.tscn"), Vector2(0, -18))
		
		lordflame.Value += amount
		for i in range(0, amount): self.use_super_meter(self.MAX_SUPER_METER / 2)
		amount = 0
		
func spawn_quake_limited(x):
	var found_quakes = 0
	
	for obj in self.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == self and obj.get("tag") == "Quake":
			found_quakes += 1
	
	if found_quakes < 1:
		self.spawn_object(preload("res://_NokColossusR/characters/colossus/projectiles/Quake.tscn"), x, 0, true, null, true)

# ---------------------------------------------------------------------------------------------------------------
func on_got_hit_by_fighter():
	if self.has_hyper_armor == true:
		self.current_state().on_armor_hit("Opponent")
		
	else:
		flamestain.Burning = false

func on_got_hit_by_projectile():
	if self.has_hyper_armor == true:
		self.current_state().on_armor_hit("Projectile")
		
	else:
		flamestain.Burning = false

func on_parried():
	.on_parried()
	
	fortitude.Value += 15
	
	#	--	ASTAROTH PARRY TAUNT
	if $"%Stuff".skin == "Astaroth":
		if self.opponent.current_state().state_name == "Burst" and int(self.distance_to(self.opponent)) <= 40:
			self.play_sound("AS-YouSuck")
	
func on_got_blocked():
	.on_got_blocked()
	
	if self.current_state().get("block_flamestain") and self.current_state().get("has_granted_flamestain") == false:
		self.current_state().has_granted_flamestain = true
		
		increment_flamestain(self.current_state().block_flamestain)
		
	if flamestain.Burning == true and self.opponent.blocked_hitbox_plus_frames >= 2:
		self.opponent.blocked_hitbox_plus_frames += 1
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if $"%Stuff".skin == "Astaroth":
		if self.applied_style:
			afterimage(self.applied_style.extra_color_2, (hitbox.hitlag_ticks * 2) / 60.0)
	
	if obj == self.opponent:
		if self.current_state().get("hit_flamestain") and self.current_state().get("has_granted_flamestain") == false:
			self.current_state().has_granted_flamestain = true
			
			increment_flamestain(self.current_state().hit_flamestain)
			
		#	--	ASTAROTH COUNTERHIT TAUNT
		if $"%Stuff".skin == "Astaroth":
			if self.counterhit_this_turn or self.opponent.guard_broken_this_turn:
				match self.randi_range(1, 3):
					1:
						self.play_sound("AS-YouSuck")
					2:
						self.play_sound("AS-Excellent")
					3:
						self.play_sound("AS-Laugh1")
					
#func gain_super_meter_raw(amount):
 
	#	--	80% METER GAIN
	#amount *= 0.8
	#.gain_super_meter_raw(amount)

#	--	ARMORED GUARDBREAK FAILSAFE
#func update_advantage():
	#.update_advantage()
	
	#if initiative == true:
		#initiative = hits_with_armor.Opponent < 1

func on_blocked_something():
	.on_blocked_something()
	
	if fortitude.Value < fortitude.WeaknessThreshold:
		if self.blocked_hitbox_plus_frames >= 1:
			self.blocked_hitbox_plus_frames += 1
		
		if fortitude.WeaknessBlockFortitudeGiven == false:
			fortitude.WeaknessBlockFortitudeGiven = true
			fortitude.Value += 10
			self.play_sound("GraceFortitude")
			self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star2.tscn"), Vector2(0, -18))

# ---------------------------------------------------------------------------------------------------------------
func afterimage(color:Color = Color.white, lifetime = 0.2):
	
	#	--	COPIED FROM _create_speed_after_image()
	var speed_image_effect = preload("res://fx/SpeedImageEffect.tscn")
	var texture = sprite.frames.get_frame(sprite.animation, sprite.frame)
	var effect = _spawn_particle_effect(speed_image_effect, get_pos_visual() + sprite.offset)
	effect.set_texture(texture)
	effect.lifetime = lifetime
	effect.set_color(color)
	effect.sprite.flip_h = get_facing_int() == - 1
	
	effect.get_node("Sprite").material = self.sprite.material

func super_effect(freeze_ticks = 0):
	.super_effect(freeze_ticks)
	
	self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Super.tscn"), Vector2(0, -18))

func process_extra(extra):
	.process_extra(extra)

	#	--	PREVENTING FLAMESTAIN SPAM
	flamestain.HasBurnedThisTurn = false

	if extra.armor == true:
		buffer_armor = true
	
	if extra.sword == true:
		buffer_css = "Sword"
		
	if extra.flame == true:
		buffer_css = "Flame"
	
	if extra.conversion > 0:
		buffer_conversions = extra.conversion
		
	if extra.quake == true:
		buffers.quake = true
		
	if extra.blade == true:
		buffers.blade = true
	
func _process(delta):
	._process(delta)
	
	#	--	LABELS
	if is_instance_valid($"%Info"):
		
		$"%Info".visible = self.is_ghost
		$"%Info".bbcode_text = "[center]"

		$"%Info".bbcode_text += "[color=#686f99]Fortitude: " + str(fortitude.Value)
		if lordflame.Value > 0: $"%Info".bbcode_text += "[center][color=#ff8933]Lordflames: " + str(lordflame.Value) + "[/color]"
		if armor_broken_this_turn == true: $"%Info".bbcode_text += "\n[color=#FF8888]Armor broken[/color]"
		if fortitude.Value < fortitude.WeaknessThreshold: $"%Info".bbcode_text += "\n[color=#722020]Low Fortitude\n-1 block advantage"
		if flamestain.Value > 0: $"%Info".bbcode_text += "\n[color=#FF8888]Flamestain: " + str(flamestain.Value) + "[/color]"
		
		var i = 16
		if flamestain.Burning == true:
			if current_tick % i <= (i / 2) - 1:
				$"%Info".bbcode_text += "\n!! [color=#FF0000]Burning[/color] !!"
				
			else:
				$"%Info".bbcode_text += "\n!! [color=#FFFFFF]Burning[/color] !!"
			
	#if is_instance_valid($"%OppIntoPositioner") and is_instance_valid($"%OppInfo"):
		#var pos = self.get_pos()
		#var opos = self.opponent.get_pos()
		#$"%OppIntoPositioner".position = Vector2(opos.x - pos.x, opos.y - pos.y)
		
		#$"%OppInfo".visible = self.is_ghost
		#$"%OppInfo".bbcode_text = "[center]"
		
		#if flamestain.Value > 0: $"%OppInfo".bbcode_text += "[color=#ff8933]Flamestain: " + str(flamestain.Value)

func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokColossusR/characters/colossus/effects/CSR-Parry.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

# ---------------------------------------------------------------------------------------------------------------

#	--	STYLE COLOURISATION
func request_style_modulation(obj):
	if $"%Stuff".style_colors:
		$"%Stuff".recursive_style_modulation(obj)

func spawn_object(projectile:PackedScene, pos_x:int, pos_y:int, relative = true, data = null, local = true):
	var obj = .spawn_object(projectile, pos_x, pos_y, relative, data, local)
	
	obj.sprite.frames = self.sprite.frames
	obj.sprite.material = self.sprite.material
	
	if self.applied_style:
		request_style_modulation(obj)
		
	return obj

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var obj = ._spawn_particle_effect(particle_effect, pos, dir)
	
	if self.applied_style:
		request_style_modulation(obj)
	
	return obj

# ---------------------------------------------------------------------------------------------------------------
func global_hitlag(amount, force = false):
	.global_hitlag(amount, true)

func init(pos = null):
	
	MAX_HEALTH = 1600
	fortitude.Value = 80
	
	if self.infinite_resources == true:
		lordflame.Value = lordflame.Max
	
	.init(pos)
	$"%Stuff"._start()

func tick_before():
	.tick_before()
	
	if self.queued_action:
		armor_broken_this_turn = false

func tick():
	.tick()
	$"%Stuff"._tick()
	
	if current_tick == 1:
		request_style_modulation($"%flame-aura1")
		request_style_modulation($"%flame-aura2")
	
	#	--	HEAVYFRAY SPAM PREVENTION
	if self.previous_state():
		if self.current_state().state_name == "Landing" and self.previous_state().state_name == "heavyfray":
			self.current_state().interrupt_exceptions.append("heavyfray")
	
	#	--	COLLISION NUDGE
	#if (self.is_colliding_with_opponent() == true and self.opponent.combo_count < 1) and self.opponent.collision_box.overlaps(self.collision_box):
		#if self.hitlag_ticks < 1 and self.opponent.hitlag_ticks < 1:
			#if self.opponent.get_pos().x > self.get_pos().x:
				#self.apply_force("-0.2", "0")
				
			#else:
				#self.apply_force("0.2", "0")
				
	#	--	BLADE VERIFICATION
	if end_blade and (not self.obj_from_name(end_blade)):
		end_blade = null
	
	#	--	FORTITUDE
	if current_tick % fortitude.AutoGain == 0 and fortitude.Value < fortitude.AutoGainMax:
		if (not self.current_state().state_name in ["Start"]) and self.opponent.combo_count < 1:
			if not (self.current_state().type in [4, 5] and not "AllowFortitude" in self.current_state().editor_description):
				if self.blockstun_ticks < 1:
					fortitude.Value += 1
	
	if fortitude.Value < fortitude.WeaknessThreshold:
		self.damage_taken_modifier = str(fortitude.WeaknessExtraDMG)
		
	else:
		self.damage_taken_modifier = str(1.0)
		
	if self.turn_frames == 1:
		fortitude.WeaknessBlockFortitudeGiven = false
			
	#	--	LORDFLAMES
	get_max_lordflames_possible()
	
	if buffer_conversions > 0:
		convert_lordflames(buffer_conversions)
		buffer_conversions = 0
		
	lordflame.Value = clamp(lordflame.Value, 0, lordflame.Max)
	
	#	--	STANCE CHANGE
	if buffer_css and buffer_css != current_special_stance:
		current_special_stance = buffer_css

		if current_special_stance == "Sword":
			self.play_sound("EquipSword")
			self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-SwordSwitch.tscn"), Vector2(0, -18))
			
		elif current_special_stance == "Flame":
			self.play_sound("EquipFlame")
			self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameSwitch.tscn"), Vector2(0, -18))
		
		buffer_css = null

	if current_special_stance == "Flame" and lordflame.Value < 1:
		current_special_stance = "Sword"
	
	#	--	FLAMESTAIN REDUCTION
	if self.turn_frames == 1:
		if self.opponent.current_state().state_name in ["ParrySuper"]:
			increment_flamestain(-1, false, false)
	
	#	--	FLAMESTAIN
	if flamestain.HasBurnedThisTurn == false and self.current_state().get("dont_burn_during") != true:
		flamestain.HasBurnedThisTurn = true
		
		if flamestain.Burning == true and flamestain.TurnLocked != true:
			increment_flamestain(-0.5, false, false)
			
			if flamestain.Value <= 0:
				flamestain.Burning = false
				
			else:
				if self.opponent.hp - flamestain.BurnDamage > 0:
					self.opponent.take_damage(flamestain.BurnDamage, flamestain.BurnDamage)
					
				var opos = self.opponent.get_pos()
				self.spawn_particle_effect(preload("res://_NokColossusR/characters/colossus/effects/CSR-Burn.tscn"), Vector2(opos.x, opos.y - 18))
			
	if flamestain.Burning == true:
		if self.style_extra_color_1 and $"%Stuff".style_colors:
			self.opponent.sprite.self_modulate = self.style_extra_color_2.lightened(0.5)
		else:
			self.opponent.sprite.self_modulate = Color(1, 0.54, 0.2)
	
	else:
		self.opponent.sprite.self_modulate = Color(1, 1, 1)
	
	flamestain.TurnLocked = false
	
	#	--	QUAKE
	if buffers.quake == true:
		buffers.quake = false
		
		for quake in self.objs_map.values():
			if is_instance_valid(quake) and quake.disabled != true and quake.get_owner() == self and quake.get("tag") == "Quake":
				if quake.current_state().state_name == "Default":
					quake.change_state("Shockwave")
	
	#	--	END BLADE
	if buffers.blade == true:
		buffers.blade = false
		
		if end_blade:
			self.obj_from_name(end_blade).prime()
			
			self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(0, -30))
	
	#	--	VISUALS
	$"%flame-aura1".emitting = (current_special_stance == "Flame")
	$"%flame-aura2".emitting = (current_special_stance == "Flame")
	
	#	--	FIRE PARTICLES ON FIRE MOVE HITBOXES
	for hbox in self.get_active_hitboxes():
		if "FireParticles" in hbox.misc_data and self.hitlag_ticks < 1 and self.blockstun_ticks < 1:
			var fire_particle = self._spawn_particle_effect(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles.tscn"), Vector2(self.get_pos().x + (hbox.x * self.get_facing_int()), self.get_pos().y + hbox.y), Vector2.RIGHT)
			var true_particle = fire_particle.get_node("%flame")
			
			if true_particle:
				true_particle.emission_rect_extents = Vector2(hbox.width, hbox.height)
				true_particle.amount = (hbox.width + hbox.height) / 4
				true_particle.restart()
				
	#	--	SKIN
	if $"%Stuff".skin == "Astaroth":
		if self.sprite.material.get_shader_param("use_extra_color_2") == false:
			if self.applied_style:
				self.applied_style.extra_color_2 = Color("#00ff95")
		
		if self.applied_style:
			var afterimage_color = self.applied_style.extra_color_2
			afterimage_color.a = 0.75 * (float(lordflame.Value) / float(lordflame.Max))
			afterimage(afterimage_color, 0.1)
