extends Fighter

#	---------------------------------------------------------------------------------------------------------------
#	---------------------------------------------------------------------------------------------------------------

var skin_users = [
	"nok",								#	;FREE, OWNER
	"WriterNat",						#	;FREE, FRIEND
	"steph",							#	;PAID, ACCESS TO BOTH
	"Mana",								#	;PAID, ACCESS TO BOTH
	"HitsuuDesu",						#	;PAID, ACCESS TO BOTH
	"Cherry",							#	;PAID, ACCESS TO BOTH
	"Ataz",								#	;FREE, BEAT BLADE OF JUSTICE
	"ataz",								#	;FREE, BEAT BLADE OF JUSTICE
	"Pres",								#	;PAID
	"Death",							#	;PAID
	"soopernoob",						#	;PAID
	"Korbus",							#	;PAID
]

#	---------------------------------------------------------------------------------------------------------------
#	---------------------------------------------------------------------------------------------------------------

var charname = "Psycho"
var walk = 1
var run = 1

var insanity = false

var wounds = 0
var scars = 0
var grace = 0
var triggers = {
	"Haemorrhage": false,
	"Bleed": false,
}
var minimum_h_wounds = 25
var h_factor = 0.0075
var h_self_factor = 3.5
var bleeding = false

var skin_enabled = true
var skin = 0

#	--
var betrayer_users = [
	"nok",								#	;FREE, OWNER
	"WriterNat",						#	;FREE, FRIEND
	"steph",							#	;PAID, ACCESS TO BOTH
	"Mana",								#	;PAID, ACCESS TO BOTH
	"HitsuuDesu",						#	;PAID, ACCESS TO BOTH
	"Cherry",							#	;PAID, ACCESS TO BOTH
	"Ataz",								#	;FREE, BEAT BLADE OF JUSTICE
	"ataz",								#	;FREE, BEAT BLADE OF JUSTICE
	"Pres",								#	;PAID
	"Death",							#	;PAID
	"soopernoob",						#	;PAID
	"Korbus",							#	;PAID
]

func apply_style(style):
	.apply_style(style)
	
	var username = Network.pid_to_username(id)
	
	if skin_enabled == false:
		skin = 0
	else:
		if self.applied_style:
			if username in betrayer_users and "Essence of the Betrayer" in style.style_name:
				skin = 1
			else:
				skin = 0
		else:
			skin = 0
			
	return style

#	-------------------------------------------------------------------------- |
func spawn_object(projectile:PackedScene, pos_x:int, pos_y:int, relative = true, data = null, local = true):
	var obj = .spawn_object(projectile, pos_x, pos_y, relative, data, local)
	
	obj.sprite.material = self.sprite.material
		
	if $"%Stuff".skin == "Guillotine":
		$"%Stuff".guillotine_modulation(obj)
		
	return obj
	
func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var obj = ._spawn_particle_effect(particle_effect, pos, dir)
	
	if $"%Stuff".skin == "Guillotine":
		$"%Stuff".guillotine_modulation(obj)
	
	return obj
	
	#if $"%Stuff".skin == "Aimorrago":
		#return $"%Stuff".convert_particle_color(effect)
	#else:
		#return effect

func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)
	
func insanity_knife(hbox):
	var opos = self.opponent.get_pos()
	var ovel = self.opponent.get_vel()
	var spawnpos = Vector2(float(opos.x) + self.randi_range(-80, 80), float(opos.y) + self.randi_range(-80, -20))
	
	var obj = self.spawn_object(preload("res://_NokPsychoR/characters/psycho/projectiles/InsanityKnife.tscn"), spawnpos.x, spawnpos.y, false, null, false)
	obj.set_grounded(false)
	obj.set_vel(ovel.x, ovel.y)
	obj.dmg = hbox.damage
	
func get_h_damage():
	var opp_hp = self.opponent.hp
	
	return ceil((opp_hp * h_factor) * wounds)
	
func get_self_h_damage(use_scars = false):
	var self_hp = self.hp
	
	if use_scars == true:
		return ceil(h_self_factor * scars)
		
	else:
		return ceil(h_self_factor * wounds)
	
func trigger_haemorrhage(block = false):
	if wounds >= minimum_h_wounds and bleeding != true:
		if block == true:
			
			#	--	BLEED
			triggers.Bleed = true
			
			self.play_sound("Haemorrhage2")
			
			if $"%Stuff".skin == "Aimorrago":
				self.play_sound("AISound2")
			
			self.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStarH.tscn"), Vector2(0, -18))
			self.screen_bump(Vector2(0, 0), 16, 0.5)
			self.global_hitlag(35)
			
		else:
			
			#	--	HAEMORRHAGE
			triggers.Haemorrhage = true
			
			self.play_sound("Haemorrhage2")
			
			if $"%Stuff".skin == "Aimorrago":
				self.play_sound("AISound2")
			
			self.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStarH.tscn"), Vector2(0, -18))
			self.screen_bump(Vector2(0, 0), 16, 0.5)
			self.global_hitlag(35)
			
#	-------------------------------------------------------------------------- |
func on_got_blocked():
	.on_got_blocked()
	
	if insanity == true:
		grace += 3
	
	if self.current_state().get("grant_scars_on_block") != false:
		scars += 1
		
#	--	BLOCKED HAEMORRHAGE
func on_got_blocked_by(who):
	.on_got_blocked_by(who)
	
	if who == self.opponent:
		for hitbox in self.get_active_hitboxes():
			if hitbox.overlaps(who.hurtbox) and "haemorrhage" in hitbox.misc_data:
				trigger_haemorrhage(true)
				self.opponent.change_state("ParryAuto")
		
func on_got_parried():
	.on_got_parried()
	
	bleeding = false
		
func on_parried():
	wounds += 3
		
func on_got_hit():
	.on_got_hit()
	
	bleeding = false
		
func block_hitbox(hitbox, force_parry = false, force_block = false, ignore_guard_break = false, autoblock_armor = false):
	.block_hitbox(hitbox, force_parry, force_block, ignore_guard_break, autoblock_armor)
		
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if insanity == true:
		grace += 3
		#insanity_knife(hitbox)
	
	#	--	HAEMORRHAGE TRIGGER
	if obj == self.opponent and "haemorrhage" in hitbox.misc_data:
		trigger_haemorrhage(false)
					
#	-------------------------------------------------------------------------- |
func global_hitlag(amount, force = false):
	.global_hitlag(amount, true)

func _process(delta):
	._process(delta)
	
	#	--	INFO DISPLAY
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	if wounds > 0: $"%Info".append_bbcode("[color=#FF0000]Wounds: " + str(wounds) + "[/color]\n")
	if grace > 0: $"%Info".append_bbcode("[color=#FFFFFF]Grace: " + str(grace) + "[/color]\n")
	if scars > 0: $"%Info".append_bbcode("[color=#FF8888]Scars: " + str(scars) + "[/color]\n\n")
	
	if bleeding == true:
		$"%Info".append_bbcode("[color=#FF8888]Opponent bleeding; cannot Haemorrhage[/color]\n")
	if wounds >= minimum_h_wounds and bleeding == false:
		$"%Info".append_bbcode("[color=#FF0000]Haemorrhage DMG: " + str(get_h_damage() * 10) + "[/color]\n")

func init(pos = null):
	.init(pos)
	
	$"%Stuff"._start()
	
	if self.infinite_resources == true:
		wounds = 50
		scars = 50
	
func tick():
	.tick()
	$"%Stuff"._tick()
	
	melee_attack_combo_scaling_applied = false
		
	#	--	INSANITY
	$"%InsanityAura".texture = self.sprite.frames.get_frame(self.sprite.animation, self.sprite.frame)
	$"%InsanityAura".visible = insanity
	$"%InsanityAura2".visible = insanity
	
	if grace > 0:
		grace -= 1
	
	if insanity == true:
		
		#	--	END ON GAME OVER
		if self.game_over == true:
			insanity = false
			
		#	SCAR CONVERSION
		if scars > 0:
			scars -= 1
			wounds += 1
		else:
			if grace <= 0:
				if self.hp > 1 and current_tick % 2 == 0:
					self.take_damage(1, 1, "0.0")
		
		#	--
		var exclusions = ["crimsonslashes"]
		
		if not self.current_state().state_name in exclusions:
			drain_super_meter(3)
			
		if self.super_meter <= 0 and self.supers_available <= 0:
			insanity = false
	
	#	--	HAEMORRHAGE
	if triggers.Haemorrhage == true:
		triggers.Haemorrhage = false
		
		var h_damage = get_h_damage()
		self.opponent.take_damage(h_damage, h_damage)
		
		var self_h_damage = get_self_h_damage()
		if self.hp - self_h_damage < 1:
			self.hp = 1
		else:
			self.take_damage(self_h_damage)
		
		wounds = 0
		self.combo_proration = 9999
		
		if $"%Stuff".skin == "Aimorrago":
			self.play_sound("Haemorrhage-AI2")
			
			if is_instance_valid($"%RedBG") and !self.is_ghost:
				$"%RedBG".visible = true
				$"%RedBG".modulate = Color(1, 0, 0, 0.25)
				
				create_tween().tween_property($"%RedBG", "modulate", Color(1, 0, 0, 0), 0.25)
			
		else:
			self.play_sound("Haemorrhage1")
			self.play_sound("Haemorrhage3")
			self.play_sound("Haemorrhage4")
			self.play_sound("Haemorrhage5")
		
		var opos = self.opponent.get_pos()
		self.spawn_particle_effect(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn"), Vector2(float(opos.x), float(opos.y) - 18))
		self.spawn_particle_effect(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit3.tscn"), Vector2(float(opos.x), float(opos.y) - 18))
		
		self.screen_bump(Vector2(0, 0), 32, 0.5)
		
	#	--	BLEED
	if triggers.Bleed == true:
		triggers.Bleed = false
		bleeding = true
		
		var self_h_damage = get_self_h_damage()
		if self.hp - self_h_damage < 1:
			self.hp = 1
		else:
			self.take_damage(self_h_damage)
		
		self.play_sound("Haemorrhage4")
		self.play_sound("HaemorrhageBleed1")
		self.play_sound("HaemorrhageBleed2")
		
		var opos = self.opponent.get_pos()
		self.spawn_particle_effect(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn"), Vector2(float(opos.x), float(opos.y) - 18))
		self.spawn_particle_effect(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit3.tscn"), Vector2(float(opos.x), float(opos.y) - 18))
		
		self.screen_bump(Vector2(0, 0), 32, 0.5)
		
	if self.opponent.parried_last_state:
		bleeding = false
		
	if bleeding == true:
		if wounds < 1:
			bleeding = false
		
		else:
			if current_tick % 2 == 0:
				wounds -= 1
				
			if current_tick % 2 == 0:
				self.opponent.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoBleed.tscn"), Vector2(0, -18))
			
			if self.opponent.hp > 1:
				self.opponent.take_damage(1, 1)
			
			if self.opponent.blocked_hitbox_plus_frames == 0:
				self.opponent.blocked_hitbox_plus_frames = 1
	
	#	--	SKIN STUFF
	if $"%Stuff".skin == "Aimorrago":
		self.sprite.frames = preload("res://_NokPsychoR/characters/psycho/skins/aimorrago/PsychoSF-AI.tres")
		$"%AI-Halo".visible = true
		
		#	--
		var visual_float_offset = sin(current_tick * 0.1) * 3
		
		if self.current_state().state_name in ["Wait"]:
			self.sprite.offset.y = lerp(self.sprite.offset.y, -18 + visual_float_offset, 0.25)
			
		else:
			self.sprite.offset.y = lerp(self.sprite.offset.y, -18, 0.1)
			
		#	--
		var offset_vel = Vector2((-int(self.get_vel().x)) * self.get_facing_int(), -int(self.get_vel().y))
		var lerp1 = lerp($"%AI-Halo".position, Vector2((offset_vel.x * 2) + sprite.offset.x, (offset_vel.y * 2) + (sprite.offset.y + 18)), 0.5)
		$"%AI-Halo".position = lerp1
		
		#	--
		if $"%Stuff".do_skin_afterimage == true:
			afterimage(Color(1, 0, 0, 0.5), 0.1)	
		
	else:
		$"%AI-Halo".visible = false
		self.sprite.frames = preload("res://_NokPsychoR/characters/psycho/PsychoSF.tres")
		self.sprite.offset.y = -18
		
	#	--
	if $"%Stuff".skin == "Guillotine" and insanity:
		if current_tick % 2 == 0:
			self.rumble(0.5, 2)
