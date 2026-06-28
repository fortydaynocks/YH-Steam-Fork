extends Fighter

var tweens = {
	
}
export (Dictionary) var colors = {}

var charname = "Colossus"
var walk = 1

var force_pips = 0
var max_force_pips = 7
var last_force_pips = 0
var force_armor = false
var startup_reduction = false
var startup_reduction_count = 0
var last_combo_count = 0
var combo_moves = {}

var sword_attacks_used = [0, 4]

"""
the number of moves used in a combo will be recorded.
moves such as full circle and falter will be significantly nerfed if used more than once in combo.

"""

var aston = false
var skin = 0
var skin_enabled = true

var asta_emotes = {
	"Parry": [
		"Is THAT your best?",
		"PITIFUL!",
		"SO predictiable...",
		"Get the hell off me.",
		"OUTCLASSED!",
		"Total nonsense!",
		"",
	],
	
	"Grab": [
		"Maaaan... what a drag.",
		"Try a bit harder, yeah?",
		"You aren't making this fun, y'know...",
		"Sooo boring!",
		"Really now?",
		"",
		"",
	],
	
	"Punch": [
		"BAM!",
		"HA!",
		"",
		"",
		"",
		"",		
	],
	
	"Falter": [
		"Collapse!",
		"A little pain therapy.",
		"You think you're SAFE?",
		"You're DONE!",
		"You know what's next...",
	],
	
	"RubbleDuster": [
		"You're kinda boring me...",
		"Does it hurt!? Tell me it does!",
		"I'm expecting more from you!",
		"Show me your soul is even worth taking.",
		"HAHA! How unfortunate.",
	],
	
	"WideSlash": [
		"Weak!",
		"HAHAHA!",
		"Get outta here.",
		"Die!",
		"Too bad!",
		"[shake rate=40 level=10 connected=1]BOOM!!",
	],
	
	"MassBreaker": [
		"[shake rate=40 level=10 connected=1]I'LL CRUSH YOU!!",
		"[shake rate=40 level=10 connected=1]GET READY!!",
		"[shake rate=40 level=10 connected=1]LET'S GET DOWN TO EARTH!!",
		"[shake rate=40 level=10 connected=1]HAA-HAHAHAHAHA!!",
		"[shake rate=40 level=10 connected=1]BRACE YOURSELF!!",
		"[shake rate=40 level=10 connected=1]YOU'RE ALWAYS IN RANGE!",
	],
	
	"AresGodSlicer": [
		"I'll burn your soul to BITS!!",
		"Die by the fire of ASTAROTH!!",
		"You'd better watch the hell out!",
		"God Slicer... yeah... [shake rate=40 level=15 connected=1]THAT'S GOOD!",
	],
	
	"DivinitysEnd": [
		"[shake rate=40 level=10 connected=1]GRIMOTHY!! GET THEIR ASS!!",
	],
	
}
var asta_emote_tween

export (Resource) var skins

#	--
func apply_style(style):
	.apply_style(style)
	
	skin = 0
	
	var user_name = Network.pid_to_username(id)
	if skin_enabled == true:
		if [user_name, 1] in skins.values:			
			if "Essence of Astaroth" in style.style_name:
				skin = 1

func do_asta_text(array, speed, fadeout):
	if skin == 1 and is_instance_valid($"%AstaEmote"):
		if asta_emote_tween: asta_emote_tween.kill()
		
		$"%AstaEmote".bbcode_text = "[center]" + self.randi_choice(array)
		$"%AstaEmote".percent_visible = float(0)
		$"%AstaEmote".modulate = Color(1, 1, 1, 1)
		
		asta_emote_tween = create_tween()
		asta_emote_tween.tween_property($"%AstaEmote", "percent_visible", float(1), 0.5)
		asta_emote_tween.tween_property($"%AstaEmote", "modulate", Color(1, 1, 1, 0), 2)

#	--

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokColossus/characters/colossus/effects/ColossusParryEffect.tscn")

	#	--
	
	if skin == 1:
		if particle_effect == preload("res://_NokColossus/characters/colossus/effects/ColossusHit1.tscn"):
			particle_effect = preload("res://_NokColossus/characters/colossus/skins/astaroth/effects/ColossusAstaHit1.tscn")
			
		if particle_effect == preload("res://_NokColossus/characters/colossus/effects/ColossusHit2.tscn"):
			particle_effect = preload("res://_NokColossus/characters/colossus/skins/astaroth/effects/ColossusAstaHit2.tscn")
			
		if particle_effect == preload("res://_NokColossus/characters/colossus/effects/ColossusHitArmor.tscn"):
			particle_effect = preload("res://_NokColossus/characters/colossus/skins/astaroth/effects/ColossusAstaHitArmor.tscn")
			
		if particle_effect == preload("res://_NokColossus/characters/colossus/effects/ColossusSlash1.tscn"):
			particle_effect = preload("res://_NokColossus/characters/colossus/skins/astaroth/effects/ColossusAstaSlash1.tscn")

	var obj = ._spawn_particle_effect(particle_effect, pos, dir)
	
	if skin == 1:
		for p in obj.get_children():
			if p.get("color"):
				var c = sprite.material.get("shader_param/extra_color_1")
				c.a = p.color.a
				p.color = c
			
			# and sprite.material.shader.get("extra_color_1"):
				#p.color = self.style.get("extra_color_1")
	
	return obj

#	--

func add_force_pips(amount):
	force_pips += amount
	
	if force_pips >= max_force_pips:
		force_pips = max_force_pips
	
func remove_force_pips(amount):
	force_pips -= amount
	
	if force_pips <= 0:
		force_pips = 0
		
func update_force_display(show_text = false):
	if is_instance_valid($"%ForceDisplay") and is_instance_valid($"%ForceText"):	
		if self.is_ghost == true and show_text == true:
			$"%ForceText".visible = true
			$"%ForceText".bbcode_text = "[center] Force: " + str(force_pips)
			
		if force_pips != last_force_pips:
			$"%ForceDisplay".rect_scale = Vector2(2, 2)
			$"%ForceDisplay".modulate = Color(1, 1, 1, 1)
			
			if tweens.has("ForceDisplay"): tweens.ForceDisplay.kill()
			else: tweens.ForceDisplay = null
			tweens.ForceDisplay = create_tween()
			var t1 = tweens.ForceDisplay.tween_property($"%ForceDisplay", "rect_scale", Vector2(1.25, 1.25), 0.3)
			t1.set_trans(Tween.TRANS_EXPO)
			t1.set_ease(Tween.EASE_OUT)
		
		$"%ForceDisplay".texture.region.position.x = $"%ForceDisplay".texture.region.size.x * force_pips
		if tweens.has("ForceDisplay2"): tweens.ForceDisplay2.kill()
		else: tweens.ForceDisplay2 = null
		tweens.ForceDisplay2 = create_tween()
		tweens.ForceDisplay2.tween_property($"%ForceDisplay", "modulate", Color(1, 1, 1, 0.25), 0.3)

#	--

func on_got_blocked():
	.on_got_blocked()

	add_force_pips(1)
	
func block_hitbox(hitbox, force_parry = false, force_block = false, ignore_guard_break = false, autoblock_armor = false):
	.block_hitbox(hitbox, force_parry, force_block, ignore_guard_break, autoblock_armor)

	if self.parried == true:
		add_force_pips(1)
		
func on_got_hit_by_projectile():
	.on_got_hit_by_projectile()
	
	#	--
	if current_state().state_name != "Grabbed":
		if force_pips > 0 and force_armor == true:
			self.has_hyper_armor = true

			self.emit_signal("super_started", 5)
		
			self.play_sound("HitArmor")
			self.play_sound("HitArmor2")
			self.spawn_particle_effect_relative(preload("res://_NokColossus/characters/colossus/effects/ColossusHitArmor.tscn"), Vector2(0, -18))
	
		#	--
		
		remove_force_pips(1)

func on_got_hit_by_fighter():
	.on_got_hit_by_fighter()
	
	#	--
	if force_pips > 0 and force_armor == true and self.initiative == true and self.opponent.combo_count < 1:
		var exceptions = ["Grabbed", "Burst", "DefensiveBurst", "OffensiveBurst"]
		
		if (not self.current_state().state_name in exceptions) and (not self.opponent.current_state().state_name in exceptions):
			self.has_hyper_armor = true
			self.emit_signal("super_started", 5)
			self.opponent.emit_signal("super_started", 6)
			
			if self.current_state().interruptible_on_opponent_turn != true:
				self.current_state().next_state_on_hold = false
			
			self.current_state().interruptible_on_opponent_turn = true
			self.opponent.current_state().enable_hit_cancel()
			
			self.play_sound("HitArmor")
			self.play_sound("HitArmor2")
			self.spawn_particle_effect_relative(preload("res://_NokColossus/characters/colossus/effects/ColossusHitArmor.tscn"), Vector2(0, -18))
			
		remove_force_pips(1)


#	--

func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)

func init(pos = null):
	
	MAX_HEALTH = 1750
	.init(pos)

func tick():
	.tick()
	
	if skin == 1:
		sprite.frames = preload("res://_NokColossus/characters/colossus/skins/astaroth/ColossusAstarothSpriteFrames.tres")
		sprite.material.shader = preload("res://_NokColossus/characters/colossus/skins/astaroth/ColossusAstarothShader.gdshader")
	else:
		sprite.frames = preload("res://_NokColossus/characters/colossus/ColossusSpriteFrames.tres")
	
	#	--
	melee_attack_combo_scaling_applied = false
	
	#	--
	$"%lens1".visible = aston
	$"%lens2".visible = aston
	$"%dots1".visible = aston
	
	#	--
	if current_state().state_name != "Grabbed" and self.initiative == true:
		if self.force_armor == true and force_pips > 0:
			self.has_hyper_armor = true


	#	--
	if combo_count <= 0:
		sword_attacks_used[0] = 0
	
		if last_combo_count >= 3:
			add_force_pips(1)
	
	last_combo_count = combo_count
	
	#	-- UI
	if self.turn_frames == 1:
		update_force_display(true)
		
	last_force_pips = force_pips
	
	$"ExhaustionText".visible = (sword_attacks_used[0] >= sword_attacks_used[1] and self.is_ghost)
