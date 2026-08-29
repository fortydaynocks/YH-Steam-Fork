extends Fighter

var buffers = {
	"flash": false
}

var charname = "Venerator"

#	========================================================================= >
onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")

var blessings = {
	"value": 0,
	"max": 3,
	"parry": [0, 60],
	"grab": [0, 150],
}

var protoflash = false

#	========================================================================= >
func afterimage(color:Color = Color.white, lifetime = 0.2):
	if color == Color("#f0b541") and self.applied_style and self.applied_style.get("extra_color_2"):
		color = self.applied_style.get("extra_color_2")
	
	self._create_speed_after_image(color, lifetime)
	
func gain_blessing(value = 1):
	blessings.value = clamp(blessings.value + value, 0, blessings.max)
	
	if value > 0:
		self.play_sound("Blessing")
		self.play_sound("Blessing2")
		self.spawn_particle_effect_relative(
			preload("res://_NokVenerator/venerator/effects/VN-Blessing.tscn"),
			Vector2(0, -18)
		)
	
func reset_blessings():
	blessings.value = 0

#	========================================================================= >
func global_hitlag(amount, force = false):
	.global_hitlag(amount, true)	#	// FORCED HITLAG

func on_parried():
	.on_parried()
	
	if self.opponent.got_parried and blessings.parry[0] < 1:
		gain_blessing()
		blessings.parry[0] = blessings.parry[1]
		
func spawn_object(projectile:PackedScene, pos_x:int, pos_y:int, relative = true, data = null, local = true):
	var obj = .spawn_object(projectile, pos_x, pos_y, relative, data, local)
	
	obj.sprite.frames = self.sprite.frames
	obj.sprite.material = self.sprite.material
	
	if self.applied_style and self.applied_style.get("extra_color_2"):
		$"%Stuff".recursive_style_modulation(obj)
		
	return obj

func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokVenerator/venerator/effects/nokparry/VN-Parry.tscn")
		
	if particle_effect == preload("res://fx/FlawedParryEffect.tscn"):
		particle_effect = preload("res://_NokVenerator/venerator/effects/VN-StarTiny.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var obj = ._spawn_particle_effect(particle_effect, pos, dir)
	
	if self.applied_style and self.applied_style.get("extra_color_2"):
		$"%Stuff".recursive_style_modulation(obj)
	
	return obj

func process_extra(extra):
	.process_extra(extra)

	buffers.flash = extra.get("flash") == true
			
	if buffers.flash == true:
		buffers.flash = false
		
		self.use_super_bar()
		self.play_sound("Protostar")
		
		var dist = 100
		var offset = 0
		var dir = xy_to_dir(self.current_di.x * self.get_facing_int(), self.current_di.y, str(dist))
		
		var proj = self.spawn_object(star, int(dir.x) + offset, int(dir.y) - 18, true, null, true)
		proj.set_grounded(false)
		
#	========================================================================= >
func init(pos = null):
	.init(pos)
	$"%Stuff"._start()
	
	self.melee_attack_combo_scaling_applied = false

func tick():
	.tick()
	$"%Stuff"._tick()
	
	if self.infinite_resources:
		blessings.value = blessings.max
	
	#	-- TIMERS
	blessings.parry[0] = clamp(blessings.parry[0] - 1, 0, INF)
	blessings.grab[0] = clamp(blessings.grab[0] - 1, 0, INF)

	#	--	FLASH
	if buffers.flash:
		buffers.flash = false
		
		var dist = 100
		var offset = 50
		var dir = xy_to_dir(self.current_di.x * self.get_facing_int(), self.current_di.y, str(dist))
		
		var proj = self.spawn_object(star, int(dir.x) + offset, int(dir.y) - 18, true, null, true)
		proj.set_grounded(false)
			
	if current_tick == 1:
		$"%Stuff".recursive_style_modulation(self)

func _process(d):
	._process(d)
	
	#	--	IDLE FLOAT
	var visual_float_offset = sin(current_tick * 0.1) * 3
	
	if self.current_state().state_name in ["Wait"]:
		self.sprite.offset.y = lerp(self.sprite.offset.y, -18 + visual_float_offset, 0.25)
		
	else:
		self.sprite.offset.y = lerp(self.sprite.offset.y, -18, 0.1)
	
	#	--	INFO DISPLAY
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	match blessings.value:
		0: $"Info".bbcode_text += "[color=#f0b541]%s[/color]\n" % "[- - -]"
		1: $"Info".bbcode_text += "[color=#f0b541]%s[/color]\n" % "[0 - -]"
		2: $"Info".bbcode_text += "[color=#f0b541]%s[/color]\n" % "[0 0 -]"
		3: $"Info".bbcode_text += "[color=#f0b541]%s[/color]\n" % "[0 0 0]"
		_: $"Info".bbcode_text += "[color=#f0b541]%s[/color]\n" % "[- - -]"
	$"%Info".bbcode_text += "[color=#f0b541]%s/%s Blessings[/color]\n" % [str(blessings.value), str(blessings.max)]
	
	if blessings.parry[0] > 0:
		$"%Info".bbcode_text += "[color=#ff8933]Blessed [Parry]: %s[/color]\n" % blessings.parry[0]
		
	if blessings.grab[0] > 0:
		$"%Info".bbcode_text += "[color=#ff8933]Blessed [Grab]: %s[/color]\n" % blessings.grab[0]
	#how tf does substitution work
	
	if self.current_state().state_name in ["voyage"] and self.current_state().current_tick >= 12:
		if self.current_state().redirect_times > 0:
			$"%Info".bbcode_text += "[color=#8f8f8f]Redirect [%s] time(s) with DI]\nUses air movement[/color]\n" % self.current_state().redirected[0]
		
	
