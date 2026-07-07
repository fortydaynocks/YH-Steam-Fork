extends Fighter

export (Resource) var stuff
export (Resource) var vip

var buffers = {
	"stream": false,
}

var charge = {
	"value": 0, 
	"max": 3
}

var static_elec = {
	"Value": 3,
	"Max": 3,
	"Recover": 0,
	"RecoverMax": 20,
}

var flash = {
	"Value": 2,
	"Max": 2,
}

var stream_target = [null, null]

#	-------------------------------------------------------------------------- |
func apply_style(style):
	.apply_style(style)
	
	# <--	COOL SHADER STUFF	-->	
	if !self.is_ghost:
		match charge.value:
			0:
				self.sprite.material.set_shader_param("extra_color_1", stuff.colors.Charge0)
			1:
				self.sprite.material.set_shader_param("extra_color_1", stuff.colors.Charge1)
			2:
				self.sprite.material.set_shader_param("extra_color_1", stuff.colors.Charge2)
			3:
				if self.current_tick % 4 in [0, 1]:
					self.sprite.material.set_shader_param("extra_color_1", stuff.colors.Charge3)
				else:
					self.sprite.material.set_shader_param("extra_color_1", stuff.colors.Charge2)
					
		self.sprite.material.set_shader_param("use_extra_color_1", true)
		self.sprite.material.set_shader_param("extra_replace_color_1", self.extra_color_1)
		
	# <--	SKIN STUFF	-->
	
	if !self.is_ghost:
		vip.skin = null
		
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
			#if is_instance_valid($"%PrivelegeText") and self.is_ghost == false:
				#$"%PrivelegeText".bbcode_text = "[center][" + title + "]\n" + username

#	-------------------------------------------------------------------------- |

func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)

#	-------------------------------------------------------------------------- |
func init(pos = null):
	.init(pos)
	
	stuff.init()
	
func process_extra(extra):
	.process_extra(extra)
	
	if extra.get("stream") == true:
		buffers.stream = true
		
	
func tick():
	.tick()
	
	if current_tick % 60 == 0:
		charge.value += 1
	
	# <--	TEMPORARY CHARGE OVER TIME	-->	
	#if self.current_tick % 20 == 0:
		#charge.value += 1
		
		#if charge.value > charge.max:
			#charge.value = 0
	
	# <--	STYLE COLORING	-->	
	apply_style(self.applied_style)
	
	#	--	PRIVLEGES ---
	if vip.skin in ["Oracle"]:
			
		self.sprite.frames = vip.skin_sprites
		
		stuff.colors.Charge0 = vip.oracle_colors.Charge0
		stuff.colors.Charge1 = vip.oracle_colors.Charge1
		stuff.colors.Charge2 = vip.oracle_colors.Charge2
		stuff.colors.Charge3 = vip.oracle_colors.Charge3
			
		$"%OR-Halo".visible = true
		$"%OR-Halo".material = self.sprite.material
			
		var offset_vel = Vector2((-int(self.get_vel().x)) * self.get_facing_int(), -int(self.get_vel().y))
		$"%OR-Halo".position = lerp($"%OR-Halo".position, Vector2(offset_vel.x * 2, offset_vel.y * 2), 0.2)
	
		if current_tick % 2 == 0 and !self.is_ghost:
			self.afterimage(stuff.colors.Charge1, 0.1)
	
	else:
		$"%OR-Halo".visible = false
		
		stuff.colors.Charge0 = stuff.default_colors.Charge0
		stuff.colors.Charge1 = stuff.default_colors.Charge1
		stuff.colors.Charge2 = stuff.default_colors.Charge2
		stuff.colors.Charge3 = stuff.default_colors.Charge3
		
	#	--	STATIC
	static_elec.Value = clamp(static_elec.Value, 0, static_elec.Max)
	
	if static_elec.Value < static_elec.Max:
		static_elec.Recover += 1
		
		if static_elec.Recover >= static_elec.RecoverMax:
			static_elec.Value += 1
			static_elec.Recover = 0
		
	else:
		static_elec.Recover = 0
		
	#	--	STREAM TRAVEL
	if buffers.stream == true:
		buffers.stream = false
		
		for neuron_target in self.objs_map.values():
			if is_instance_valid(neuron_target) and neuron_target.disabled != true and neuron_target.get_owner() == self and neuron_target.get("tag") == "Neuron":
				if neuron_target.get("streaming_to"):
					stream_target[0] = neuron_target.name
					stream_target[1] = null
					
					break
	
	if stream_target[0]:
		var target_obj = self.objs_map.get(stream_target[0])
		
		if is_instance_valid(target_obj) and target_obj.disabled != true:
			
			#	--	TELEPORT
			self.set_pos(target_obj.get_pos().x, target_obj.get_pos().y + 18)
			target_obj.disable()
			
			self.play_sound("StreamDash")
			self.play_sound("StreamDash2")
			self.spawn_particle_effect_relative(preload("res://_NokJupiter/characters/jupiter/effects/JP-Misc1.tscn"), Vector2(0, -18))
			
			self.global_hitlag(4)
			
			#	--
			
			if not stream_target[1]:
				if target_obj.get("streaming_to"):
					stream_target[0] = target_obj.streaming_to
					stream_target[1] = "To"
					
				elif target_obj.get("streamed_by"):
					
					stream_target[1] = "By"
					
			if stream_target[1] == "To":
				stream_target[0] = target_obj.streaming_to
			
			elif stream_target[1] == "To":
				stream_target[0] = target_obj.streamed_by
			
			#var next_stream_target = stream_target_obj.get("streaming_to")
			#if not next_stream_target: next_stream_target = stream_target_obj.get("streamed_by")
			
			#if next_stream_target and self.objs_map.get(next_stream_target):
				#var next_stream_target_obj = self.objs_map.get(next_stream_target)
				
				#if is_instance_valid(next_stream_target_obj) and next_stream_target_obj.disabled != true:
					#stream_target_obj.disable()
					#stream_target = next_stream_target
				#else:
					#stream_target[0] = null
				
			#else:
				#stream_target[0] = null
		
	#	--	FLASH
	flash.Value = clamp(flash.Value, 0, flash.Max)
	
func _process(delta):
	._process(delta)
	
	#	--	INFO
	if is_instance_valid($"%Info"):
		$"%Info".visible = self.is_ghost
		$"%Info".bbcode_text = "[center]"
		
		$"%Info".bbcode_text += "[color=#3c6cb9]Static: " + str(static_elec.Value) + "/" + str(static_elec.Max) + "[/color]"
		if flash.Value > 0: $"%Info".bbcode_text += "\n[color=#5fcde4]Flash: " + str(flash.Value) + "[/color]"
