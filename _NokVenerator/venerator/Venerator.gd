extends Fighter

var charname = "Venerator"

#	========================================================================= >
onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")

var blessings = {
	"value": 0,
	"max": 3,
	"parry": [0, 60]
}

var voyage = {
	"left": 0,
	
	"turns_left": 0,
	"enabled": false,
	"dir": Vector2(0, 0),
	"strength": 0.5,
	"limit": 1,
	"ticks": 0,
}

var protoflash = false

#	========================================================================= >
func afterimage(color:Color = Color.white, lifetime = 0.2):
	if color == Color("#006aff") and self.applied_style and self.applied_style.get("extra_color_1"):
		color = self.applied_style.get("extra_color_1")
	
	self._create_speed_after_image(color, lifetime)
	
func gain_blessing(value = 1):
	blessings.value = clamp(blessings.value + value, 0, blessings.max)
	
	self.play_sound("Blessing")
	self.play_sound("Blessing2")
	self.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Blessing.tscn"),
		Vector2(0, -18)
	)
	
func reset_blessings():
	blessings.value = 0

#	========================================================================= >
func on_parried():
	.on_parried()
	
	if self.opponent.got_parried and blessings.parry[0] < 1:
		gain_blessing()
		blessings.parry[0] = blessings.parry[1]
		

func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokVenerator/venerator/effects/nokparry/VN-Parry.tscn")
		
	if particle_effect == preload("res://fx/FlawedParryEffect.tscn"):
		particle_effect = preload("res://_NokVenerator/venerator/effects/VN-StarTiny.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

func process_extra(extra):
	.process_extra(extra)

	if voyage.turns_left > 0 and voyage.enabled == false:
		voyage.turns_left -= 1
			
		self.spawn_particle_effect_relative(
			preload("res://fx/FeintEffect.tscn"),
			Vector2(0, -18)
		)
			
		if voyage.turns_left == 0:
			voyage.enabled = true
			voyage.ticks = 20
				
			self.reset_momentum()
			
	if protoflash == true:
		protoflash = false
		
		var dist = 100
		var offset = 50
		var dir = xy_to_dir(self.current_di.x * self.get_facing_int(), self.current_di.y, str(dist))
		
		var proj = self.spawn_object(star, int(dir.x) + offset, int(dir.y) - 18, true, null, true)
		proj.set_grounded(false)

#	========================================================================= >
func tick():
	.tick()
	
	#	-- TIMERS
	blessings.parry[0] = clamp(blessings.parry[0] - 1, 0, INF)
	
	#	--	VOYAGE
	if voyage.left > 0:
		voyage.left -= 1
		
		var pos = self.get_pos()
		var opos = self.opponent.get_pos()
		var dir = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		var speed_vec = Vector2(self.get_vel().x, self.get_vel().y)
		
		self.apply_force(str(voyage.dir.x * voyage.strength), str(voyage.dir.y * voyage.strength))
		self.apply_grav_custom("-0.25", "8")
		#self.apply_force("0", )
		
		#if speed_vec.x * self.get_facing_int() >= voyage.limit:
			#self.apply_force(str(voyage.dir.x * voyage.strength), str(voyage.dir.y * voyage.strength))
			#self.apply_forces_no_limit()
		#if speed_vec.y >= voyage.limit:
			#self.apply_force("0", )
			#self.apply_forces_no_limit()
		#if speed_vec < voyage.max_speed:
			#self.apply_force(str(voyage.dir.x * voyage.strength), str(voyage.dir.y * voyage.strength))
			#self.apply_forces_no_limit()
		
		afterimage(Color("#ff8933"), 0.1)
		afterimage(Color("#ffee83"), 0.05)
		
		if voyage.left <= 0:
			self.spawn_particle_effect_relative(
				preload("res://_NokVenerator/venerator/effects/VN-Star1.tscn"),
				Vector2(0, -18)
			)
		
	#if voyage.enabled == true:
		#if voyage.dir and voyage.ticks > 0:
			#var pos = self.get_pos()
			#var opos = self.opponent.get_pos()
			#var dir = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
			
			#self.apply_force(str(dir.x * voyage.strength), str(dir.y * voyage.strength))
			#self.apply_forces_no_limit()
			#voyage.ticks -= 1
			
			#afterimage(Color("#ff8933"), 0.1)
			#afterimage(Color("#ffee83"), 0.05)
		#else:
			#voyage.enabled = false
			#voyage.dir = null

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
	#how tf does substitution work
		
	
