extends Fighter

export (Dictionary) var objs_table
export (Dictionary) var vfx_table
export (Dictionary) var spriteframes

#	---------------------------------------------------------------------------------------------------------------
#	---------------------------------------------------------------------------------------------------------------

var super_allowed_users = [
	"nok",								#	;FREE, OWNER
]

var akuma_users = []
export (Resource) var skins

#	---------------------------------------------------------------------------------------------------------------

var buffers = {
	"Firewalk": false,
	"Firewarp": false,
	"Mark": false,
	"DemonStep": false,
	"CCEnd": false,
}

var charname = "Shin Goren"
var idle = 1
var won = false
var won2 = false
var death_quoted = false

var skin = 0
var skin_enabled = true

onready var ds_1 = $"Flip/Sprite/DS_1"
onready var ds_2 = $"Flip/Sprite/DS_2"
onready var ds_3 = $"Flip/Sprite/DS_3"

var cc = false
var ccs_in_combo = 0

var firewalk = {
	"Value": 1,
	"Max": 1,
	"Range": 45,
	"Grants": 0,
	"GrantsGiven": false
}

var active_mark = null

#	-------------------------------------------------------------------------- |
func try_firewalk():
	var pos = self.get_pos()
	var fac = self.get_facing_int()
	
	var limit = -1
	if self.current_state().get("firewalk_min"): limit = self.current_state().firewalk_min
	
	if buffers.Firewalk and firewalk.Value > 0 and (not "NoFirewalk" in self.current_state().editor_description):
		if self.current_state().current_tick >= limit:
			firewalk.Value -= 1
			
			self.blockstun_ticks = clamp(self.blockstun_ticks, -INF, 6)
			if self.combo_count > 1: self.opponent.hitlag_ticks += 4
			afterimage(Color("#ff8933"), 0.5)
			
			self.change_state("firewalk")
			
			#	--
			var opos = self.opponent.get_pos()
			var dir = xy_to_dir(-self.current_di.x, -self.current_di.y, str(firewalk.Range))
			var swirl = self.spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/Fireswirl.tscn"), opos.x + int(dir.x), (opos.y + int(dir.y)), true, null, false)
			swirl.set_grounded(false)
			swirl.apply_force(str(4 * fac), "0")
		
func afterimage(color:Color = Color.white, lifetime = 0.2):
	if color == Color("#006aff") and self.applied_style and self.applied_style.get("extra_color_1"):
		color = self.applied_style.get("extra_color_1")
	
	self._create_speed_after_image(color, lifetime)

#	-------------------------------------------------------------------------- |
func _on_hit_something(obj, hitbox):
	var exclusions = ["Burst", "DefensiveBurst", "OffensiveBurst"]
	
	if not (current_state().state_name in exclusions):
		if cc == true and not "IgnoreCC" in hitbox.misc_data:
			._on_hit_something(obj, hitbox)
			self.current_state().enable_hit_cancel(false)
			
		else:
			._on_hit_something(obj, hitbox)
			
	#	--	FIREWALK
	if obj == self.opponent:
		if firewalk.Grants > 0:
			firewalk.Grants = clamp(firewalk.Grants - 1, 0, INF)
			firewalk.Value = clamp(firewalk.Value + 1, 0, firewalk.Max)
			
		else:
			if not firewalk.GrantsGiven:
				firewalk.Grants = firewalk.Max
				firewalk.GrantsGiven = true
		
		try_firewalk()

func on_got_blocked():
	.on_got_blocked()
		
	try_firewalk()
		
func can_block_cancel():
	return .can_block_cancel() and (not buffers.Firewalk)
		
func _create_speed_after_image(color:Color = Color.white, lifetime = 0.2):
	var speed_image_effect = preload("res://fx/SpeedImageEffect.tscn")
	var texture = sprite.frames.get_frame(sprite.animation, sprite.frame)
	var effect = _spawn_particle_effect(speed_image_effect, get_pos_visual() + sprite.offset)
	effect.set_texture(texture)
	effect.lifetime = lifetime
	effect.set_color(color)
	effect.sprite.flip_h = get_facing_int() == - 1
	
	if $"%Stuff".skin == "UberOni":
		effect.set_color(Color.white)
		effect.sprite.material = self.material
	
func gain_super_meter(amount, stale_amount = "1.0"):
	if cc == true:
		.gain_super_meter(0, stale_amount)
	else:
		.gain_super_meter(amount, stale_amount)
		
func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var obj = particle_effect.instance()
	add_child(obj)

	#	--	CUSTOM COLORS
	
	#for particle in obj.get_children():
		#if particle is CPUParticles2D and particle.get("is_nok_particle") == true:
			#if skin == 1:
				#particle.modulate = particle.get("replacement_color")
			#else:
				#particle.modulate = particle.get("original_color")
	
	convert_particle_colors(obj)
			
	
	obj.tick()
	var facing = - 1 if dir.x < 0 else 1
	obj.position = pos
	if facing < 0:
		obj.rotation = (dir * Vector2( - 1, - 1)).angle()
	else :
		obj.rotation = dir.angle()
	obj.scale.x = facing

	remove_child(obj)
	emit_signal("particle_effect_spawned", obj)
	return obj

func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokGorenShin/characters/shingoren/effects/SG-Parry.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

func spawn_object(projectile:PackedScene, pos_x:int, pos_y:int, relative = true, data = null, local = true):
	var obj = .spawn_object(projectile, pos_x, pos_y, relative, data, local)
	obj.sprite.material = self.sprite.material
	
	if $"%Stuff".skin == "UberOni":
		for fx in obj.sprite.get_children():
			$"%Stuff".uber_modulation(fx)
	
	return obj

#	--
func play_voiceline(rsc):
	#	MUST HAVE
	#	"Audio" = array of sounds
	#	"Volume" = volume
	#	"Pitch" = pitch
	#	"Variation" = pitch bend
	
	$"%Voiceline".stream = self.randi_choice(rsc.audio)
	$"%Voiceline".volume_db = rsc.volume
	$"%Voiceline".pitch_scale = rsc.pitch
	$"%Voiceline".pitch_variation = rsc.variation
	
	if $"%Voiceline".stream: 
		play_sound("Voiceline")
	
	pass
	
#	-------------------------------------------------------------------------- |
func convert_particle_colors(obj):
	if $"%Stuff".skin == "Akuma":
		for ptcl in obj.get_children():
			$"%Stuff".akuma_modulation(ptcl)
	
	if $"%Stuff".skin == "UberOni":
		for ptcl in obj.get_children():
			$"%Stuff".uber_modulation(ptcl)

func unlock_codex_achievement(ach, allow_offline = false, relock_after = false):
	$"%Stuff".unlock_achievement(ach, allow_offline, relock_after)
	
	var codex = get_node_or_null("/root/CharCodexLibrary")
	
	if is_instance_valid(codex):
		if Network.multiplayer_active or allow_offline == true:
			codex.unlock_achievement(self, ach)
		
			if relock_after == true:
				codex.relock_achievement(self, ach)

#	-------------------------------------------------------------------------- |
func process_extra(extra):
	.process_extra(extra)
	
	buffers.Firewalk = extra.get("Firewalk") == true and self.opponent.combo_count < 1
	buffers.Firewarp = extra.get("Firewarp") == true
	
	if extra.get("Mark") == true:
		buffers.Mark = true
		
	if extra.get("DemonStep") == true:
		buffers.DemonStep = true
		
	if extra.get("CCEnd") == true:
		buffers.CCEnd = true

func init(pos = null):
	.init(pos)
	
	$"%Stuff"._start()

func tick_before():
	.tick_before()
		
	#	--	DEMON STEP
	if buffers.DemonStep == true and active_mark and self.obj_from_name(active_mark):
		buffers.DemonStep = false
		
		self.change_state("demonstep", Vector2(self.obj_from_name(active_mark).get_pos().x, self.obj_from_name(active_mark).get_pos().y + 18))
		self.spawn_particle_effect(preload("res://_NokGorenShin/characters/shingoren/effects/SG_MarkActivate.tscn"), Vector2(self.obj_from_name(active_mark).get_pos().x, self.obj_from_name(active_mark).get_pos().y))
		
		self.obj_from_name(active_mark).disable()
		active_mark = null

func tick():
	.tick()
	$"%Stuff"._tick()
	
	#	--
	melee_attack_combo_scaling_applied = false
	
	if self.combo_count < 1:
		ccs_in_combo = 0
		
		firewalk.Grants = 0
		firewalk.GrantsGiven = false
	
	#	--	FIREWARP
	if buffers.Firewarp and (not self.opponent.current_state().state_name in ["Grabbed"]):
		for obj in self.objs_map.values():
			if is_instance_valid(obj) and (not obj.disabled) and obj.creator == self and obj.get("tag") == "Fireswirl":
				
				var cstate = self.current_state()
				var exclusions = ["Knockdown", "HardKnockdown", "Getup"]
				if self.opponent.combo_count < 1 and (not cstate.state_name in exclusions) and (not "NoFirewarp" in cstate.editor_description):
					var warp_at = 0
					
					if cstate.get("force_warp") and cstate.force_warp > 0:
						warp_at = cstate.force_warp
						
					elif not cstate.type in [4, 5]:
						for hbox in cstate.get_children():
							if hbox is Hitbox:
								warp_at = hbox.start_tick - 2
								break
					
					if warp_at > 0:
						if cstate.current_tick >= warp_at:
							buffers.Firewarp = false
							
							self.set_pos(obj.get_pos().x, obj.get_pos().y)
							
							self.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit1.tscn"), Vector2(0, -18))
							afterimage(Color("#ff8933"), 0.5)
							
							obj.play_sound("Firewarp")
							obj.disable()
							
							break
	
	#	--	ACHV
	if self.current_tick == 1 and $"%Stuff".skin == "UberOni":
		$"%Stuff".unlock_achievement("SG-UBER", true)
	
	#	--	MARKS
	if active_mark:
		if not self.obj_from_name(active_mark):
			active_mark = null
	
	if buffers.Mark == true and self.turn_frames >= 4: 
		buffers.Mark = false
		self.use_super_bar()
		
		if self.obj_from_name(active_mark):
			self.obj_from_name(active_mark).disable()
		
		var opos = self.opponent.get_pos()
		var offset = self.xy_to_dir(self.current_di.x, self.current_di.y, "40")
		var obj = self.spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/OnisMark.tscn"), opos.x + int(offset.x), (opos.y + int(offset.y)) - 18, false, null, false)
		obj.set_grounded(false)
		
		obj.play_sound("Spawn")
		obj.play_sound("Spawn2")
		obj.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit3.tscn"), Vector2(0, 0))
		
		active_mark = obj.obj_name
	
	#	--	CUSTOM COMBO
	if cc == true:
		if buffers.CCEnd == true:
			buffers.CCEnd = false
			
			cc = false
			self.play_sound("Rage1")
			self.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Misc1.tscn"), Vector2(0, -18))
		
		else:
			if $"%Stuff".skin == "UberOni": _create_speed_after_image(Color.white, 0.1)
			elif skin == 1: _create_speed_after_image(Color.red, 0.25)
			else: _create_speed_after_image(Color.orangered, 0.25)
			
			if get_total_super_meter() <= 0:
				cc = false
				
			if combo_count >= 1:
				use_super_meter(3)
			else:
				use_super_meter(1)
			
	else:
		pass
	
	#	--	WIN SCREEN

		
#	--

func _process(delta):
	._process(delta)
	
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	if firewalk.Value > 0:
		$"%Info".bbcode_text += "\n[color=#ff8933]Firewalk: " + str(firewalk.Value) + "/" + str(firewalk.Max) + "[/color]"
	else:
		$"%Info".bbcode_text += "\n[color=#8f8f8f]Firewalk: 0/" + str(firewalk.Max) + "[/color]"
	
	if firewalk.Grants > 0:
		$"%Info".bbcode_text += "\n[color=#e64539]Grants left: " + str(firewalk.Grants)
