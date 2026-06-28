extends Fighter

var buffers = {
	"JudgeEye": null,
	"JudgeEyeType": null,
}

export (Dictionary) var objs_table
export (Dictionary) var vfx_table
export (Dictionary) var colors_table
var tweens = {
	"HelperTween": null,
}

var charname = "Betrayer"
var idle = 1
var skin = null

var applied_skin = null
var skin_enabled = true

var judgement_mode = false
var blades = {
	"Truth": false,
	"Might": false,
	"Death": false,
	"Order": false,
	"Shadow": false,
	"Acumen": false,
	"Justice": false,
}
var has_justice = false

var buffered_blade = null
var eyes = [
	
]

var bleed = 0
var judgepoints = {
	"Value": 0,
	"LastMeter": 0,
	"SpawnRange": 150,
	"DriftSpeed": 5,
	"MaxEyes": 3
}
var eyepoints = {
	"Truth": [0, 2],
	"Might": [0, 2],
	"Order": [0, 2],
	"Shadow": [0, 2],
	"Acumen": [0, 2],
	"Justice": [0, 1],
}
var granted_eyepoint = null
var knight = {
	"Knight": null,
	"NextKnightBuffer": null,
}

var abs_asc = 0

# ------------------------------------------------------------------------------------------------ |
func afterimage(color:Color = Color.white, lifetime = 0.2):
	if color == Color("#006aff") and self.applied_style and self.applied_style.get("extra_color_1"):
		color = self.applied_style.get("extra_color_1")
	
	self._create_speed_after_image(color, lifetime)
	
func grant_blade(blade_chosen):
	for blade_key in blades.keys():
		if blade_key == blade_chosen:
			buffered_blade = blade_chosen

func increment_eye_points(point, increment, show = true):
	if eyepoints.get(point):
		if show == true and increment > 0:
			if eyepoints[point][0] + increment <= eyepoints[point][1]:
				granted_eyepoint = [point, increment]
			else:
				granted_eyepoint = [point, "MAXIMUM"]
		
		eyepoints[point][0] += increment
		eyepoints[point][0] = clamp(eyepoints[point][0], 0, eyepoints[point][1])
		
func summon_knight(location, state = null, data = null):
	if knight.Knight:
		return
		
	var obj = self.spawn_object(preload("res://_NokBetrayer/characters/betrayer/projectiles/knight/KnightofOcclusion.tscn"), location.x, location.y + 27, true, null, false)
	
	obj.set_grounded(false)
	obj.set_facing(-1 if obj.get_pos().x > self.opponent.get_pos().x else 1)
	obj.sprite.material = self.sprite.material
	
	obj.next_attack = state
	
	knight.Knight = obj.obj_name
		
#	-------------------------------------------------------------------------- |
func on_got_blocked_by(who):
	.on_got_blocked_by(who)
	
	if who == self.opponent:
		if bleed > 0:
			bleed = 0
			
			if self.opponent.blocked_hitbox_plus_frames > 0:
				self.opponent.blocked_hitbox_plus_frames += 1

func color_of_1_alpha_of_2(color1: Color, color2: Color):
	return Color(color1.r, color1.g, color1.b, color2.a)

func make_particle_style_color(obj):
	return
	
	#	--	CUSTOM PARTICLE RECOLOR CODE
	#	you need the "color_of_1_alpha_of_2" function
	#	the following should be in the EditorDescriptions of the particles you want to change
	#	"C1" = modulate to color 1
	#	"C2" = modulate to color 2
	#	"RampStart" = focus on beginning of gradient
	#	"RampEnd" = focus on end of gradient
	
	#	try not to use color ramps with more than 2 points
	
	if !self.is_ghost:
		var color_1 = self.style_extra_color_1 if self.style_extra_color_1 else self.extra_color_1
		var color_2 = self.style_extra_color_2 if self.style_extra_color_2 else self.extra_color_2
		
		for particle in obj.get_children():
			if particle is CPUParticles2D:
				if "C1"in particle.editor_description:
					if "RampStart" in particle.editor_description:
						particle.color_ramp.colors[0] = color_of_1_alpha_of_2(color_1, particle.color_ramp.colors[0])
						
					elif "RampEnd" in particle.editor_description:
						particle.color_ramp.colors[1] = color_of_1_alpha_of_2(color_1, particle.color_ramp.colors[1])
						
					else:
						particle.modulate = color_of_1_alpha_of_2(color_1, particle.modulate)
					
				if "C2"in particle.editor_description:
					if "RampStart" in particle.editor_description:
						particle.color_ramp.colors[0] = color_of_1_alpha_of_2(color_2, particle.color_ramp.colors[1])
							
					elif "RampEnd" in particle.editor_description:
						particle.color_ramp.colors[1] = color_of_1_alpha_of_2(color_2, particle.color_ramp.colors[1])
							
					else:
						particle.modulate = color_of_1_alpha_of_2(color_2, particle.modulate)
	
func spawn_object(projectile:PackedScene, pos_x:int, pos_y:int, relative = true, data = null, local = true):
	var obj = .spawn_object(projectile, pos_x, pos_y, relative, data, local)
	
	obj.sprite.frames = self.sprite.frames
	obj.sprite.material = self.sprite.material
	
	if self.applied_style and self.applied_style.get("extra_color_1"):
		$"%Stuff".recursive_style_modulation(obj)
		
	return obj

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var obj = ._spawn_particle_effect(particle_effect, pos, dir)
	
	if self.applied_style and self.applied_style.get("extra_color_1"):
		$"%Stuff".recursive_style_modulation(obj)
	
	return obj
	
func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2 = Vector2(), dir = Vector2.RIGHT):
	if particle_effect == preload("res://fx/ParryEffect.tscn"):
		particle_effect = preload("res://_NokBetrayer/characters/betrayer/effects/BT-Parry.tscn")
		
	.spawn_particle_effect(particle_effect, pos, dir)

#	---------------------------------------------------------------------------------------------- |
func _process(delta):
	._process(delta)
	
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	if abs_asc > 0:
		if $"%Stuff".skin == "Munanyou":
			$"%Info".bbcode_text += "[color=#9e7deb]Divine lightning courses through you.[/color]\n Endless Judge Points"
		else:
			$"%Info".bbcode_text += "[color=#006aff]The Eye of Judgement watches.[/color]\n Endless Judge Points"
		
	else:
		$"%Info".bbcode_text += "[color=#006aff]Judge Points: [/color]" + str(judgepoints.Value)
	
	if granted_eyepoint:
		if str(granted_eyepoint[1]) == "MAXIMUM":
			$"%Info".bbcode_text += "\n[color=#80b5ff] Cannot gain Eye of [" + granted_eyepoint[0] + "]: it's maxed out"
		else:
			$"%Info".bbcode_text += "\n[color=#80b5ff]" + str(granted_eyepoint[1]) + " Eye of [" + granted_eyepoint[0] + "]"

#	--
func process_extra(extra):
	.process_extra(extra)
	
	for wanted_eye in self.objs_map.values():
		if is_instance_valid(wanted_eye) and wanted_eye.disabled != true and wanted_eye.get("judge_eye") == true and wanted_eye.get("inconsolable") == false:
			if wanted_eye.get("eye_type") == extra.activate_judge_eye:
				wanted_eye.activate()
				
	if extra.get("JudgeEye") and judgepoints.Value > 0:
		buffers.JudgeEye = extra.JudgeEye
		
	if extra.get("JudgeEyeType"):
		buffers.JudgeEyeType = extra.JudgeEyeType

#	============================================================================================== |
func global_hitlag(amount, force = false):
	.global_hitlag(amount, true)

func init(pos = null):
	.init(pos)
	$"%Stuff"._start()
	
	self.melee_attack_combo_scaling_applied = false

func tick():
	.tick()
	$"%Stuff"._tick()
	
	has_justice = blades.Justice
	
	#	--	JUDGE POINTS
	if supers_available > judgepoints.LastMeter:
		judgepoints.Value += supers_available - judgepoints.LastMeter
		
	judgepoints.LastMeter = supers_available
	
	if self.infinite_resources == true:
		judgepoints.Value = 99
		
		for eye in eyepoints:
			eyepoints[eye][0] = eyepoints[eye][1]
	
	#	--	EYE POINTS
	if self.current_state().current_tick == 1 and granted_eyepoint:
		granted_eyepoint = null
		
	#	--	JUDGE EYES
	if buffers.JudgeEye and buffers.JudgeEyeType and self.current_state().current_tick >= 4:
		if eyepoints[buffers.JudgeEyeType][0] > 0:
			judgepoints.Value -= 1
			increment_eye_points(buffers.JudgeEyeType, -1, false)
			
			var dir = xy_to_dir(buffers.JudgeEye.x, buffers.JudgeEye.y, str(judgepoints.SpawnRange))
			if buffers.JudgeEyeType == "Justice":
				dir = xy_to_dir(buffers.JudgeEye.x * 2, buffers.JudgeEye.y, str(judgepoints.SpawnRange))
			var obj = self.spawn_object(preload("res://_NokBetrayer/characters/betrayer/projectiles/JudgeEye.tscn"), int(dir.x), int(dir.y) - 18, false, null, true)
			
			obj.set_grounded(false)
			obj.eye_type = buffers.JudgeEyeType

			var drift = xy_to_dir(self.current_di.x, self.current_di.y, str(judgepoints.DriftSpeed))
			obj.apply_force(str(drift.x), str(drift.y))

			obj.play_sound("Spawn")
			obj.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1Weak.tscn"), Vector2(0, 0))
			
			buffers.JudgeEye = null
			buffers.JudgeEyeType = null

	#	--	KNIGHT
	if knight.Knight and not self.obj_from_name(knight.Knight):
		knight.Knight = null
		
	if self.opponent.combo_count < 1:
		if knight.NextKnightBuffer and not knight.Knight:
			var eye_obj = self.obj_from_name(knight.NextKnightBuffer[1])
			
			if eye_obj:
				summon_knight(eye_obj.get_pos(), eye_obj.eye_type)
				eye_obj.disable()
			
			knight.NextKnightBuffer = null

	#	--	BLEED DAMAGE
	if bleed > 0:
		if current_tick % 2 == 0:
			bleed -= 1
			
			if self.opponent.hp - 1 > 0:
				self.opponent.take_damage(1, 1)
				
			self.opponent.spawn_particle_effect_relative(vfx_table.Bleed, Vector2(0, -18))
			
	#	--	ABSOLUTE ASCENSION
	abs_asc = clamp(abs_asc, 0, INF)
	
	if self.game_over == true:
		abs_asc = 0
	
	if current_tick == 1:
		$"%Stuff".recursive_style_modulation(self)
		
	$"%AbsAscAura1".emitting = abs_asc > 0
	$"%AbsAscAura2".emitting = abs_asc > 0
	$"%AbsAscAura3".emitting = abs_asc > 0
	$"%AbsAscAura4".emitting = abs_asc > 0
		
	$"%AbsAscAura1".texture = self.sprite.frames.get_frame(self.sprite.animation, self.sprite.frame)
	
	if abs_asc > 0:
		$"%AbsAscScreen".color.a = lerp($"%AbsAscScreen".color.a, 0.05, 0.1)
		
	else:
		$"%AbsAscScreen".color.a = lerp($"%AbsAscScreen".color.a, 0, 0.1)
		
	#	--	SKIN
	#$"%Mu-Extra1".visible = $"%Stuff".skin == "Munanyou"
	#$"%Mu-Extra2".visible = $"%Stuff".skin == "Munanyou"
	
	if $"%Stuff".skin == "Munanyou":
		var vel = Vector2(int(self.get_vel().x) * self.get_facing_int(), self.get_vel().y)
		
		var lerp1 = lerp($"%Mu-Extra1".position, Vector2(vel.x * -2, (vel.y * -2) - 18), 0.2)
		var lerp2 = lerp($"%Mu-Extra2".position, Vector2(vel.x * -3, (vel.y * -3) -  18), 0.1)
		
		$"%Mu-Extra1".position = lerp1
		$"%Mu-RingPulse".position = lerp1		
		$"%Mu-Extra2".position = lerp2
		
		#	--	FLOATING
		var visual_float_offset = sin(current_tick * 0.05) * 3
		
		if self.current_state().state_name in ["Wait"]:
			self.sprite.offset.y = lerp(self.sprite.offset.y, -18 + visual_float_offset, 0.25)
			
		else:
			self.sprite.offset.y = lerp(self.sprite.offset.y, -18, 0.1)
		
		#	--	SKIN SPRITES
		#self.sprite.frames = preload("res://_NokBetrayer/characters/betrayer/skins/munanyou/BT-SF-MU.tres")
		
		#	--	AFTERIMAGE
		afterimage(self.applied_style.extra_color_2 if self.applied_style and self.applied_style.get("extra_color_2") else self.extra_color_2, 0.075)
