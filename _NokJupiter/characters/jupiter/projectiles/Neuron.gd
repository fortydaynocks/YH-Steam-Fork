extends "res://_NokJupiter/characters/jupiter/projectiles/JP-Projectile.gd"

onready var hitbox_stream = $"%HitboxStream"

var static_neuron = false

var streaming_to
var streamed_by
var stream_distance = 100
var stream_color = Color("#5fcde4")

var hit_interval = [0, 20]
var can_stream_be_active = false

var stream_colors = {
	"Active": Color("#5fcde4"),
	"Inactive": Color("3c6cb9"),
	"Disabled": Color.gray,
	"Hit": Color.white,
	
}

var lerp_time = 0.25

#	--
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if "Stream" in hitbox.misc_data:
		$"%Stream".width = 18
		$"%Stream".default_color = stream_colors.Hit
		
	hit_interval[0] = hit_interval[1]

func hit_by(hitbox):
	.hit_by(hitbox)
	
	if hitbox:
		if self.objs_map.get(hitbox.host) and self.objs_map[hitbox.host] == self.get_owner().opponent:
			disable()

func disable():
	.disable()
	
	$"%Stream".width = 0
	
	streaming_to = null
	streamed_by = null
	
	$"%StreamStars".visible = false
	$"%StreamStars2".visible = false
	
	if is_instance_valid(hitbox_stream):
		hitbox_stream.deactivate()

#	--
func tick():
	.tick()
	
	hit_interval[0] = clamp(hit_interval[0] - 1, 0, hit_interval[1])
	
	#	--	STREAM VERIFICATION
	if streaming_to:
		var stream_child = self.objs_map.get(streaming_to)
		if not is_instance_valid(stream_child) or stream_child.disabled == true:
			streaming_to = null
			
		var stream_parent = self.objs_map.get(streamed_by)
		if not is_instance_valid(stream_parent) or stream_parent.disabled == true:
			streamed_by = null
	
	else:
		if static_neuron == true:
			for other_neuron in self.objs_map.values():
				if is_instance_valid(other_neuron) and other_neuron.disabled != true and other_neuron != self and other_neuron.get_owner() == self.get_owner() and other_neuron.get("tag") == "Neuron":
					if other_neuron.static_neuron == true and int(distance_to(other_neuron)) <= stream_distance and other_neuron.streaming_to == null:
						
						#	--	BEGIN STREAMING
						streaming_to = other_neuron.obj_name
						other_neuron.streamed_by = self.obj_name
						
						self.play_sound("StreamConnect")
						self.play_sound("StreamConnect2")
						
						other_neuron.play_sound("StreamConnect")
						other_neuron.play_sound("StreamConnect2")
						
						self.spawn_particle_effect_relative(preload("res://_NokJupiter/characters/jupiter/effects/JP-Misc1.tscn"))
						other_neuron.spawn_particle_effect_relative(preload("res://_NokJupiter/characters/jupiter/effects/JP-Misc1.tscn"))
	
	#	--	CONNECTION FAILSAVES
	if streaming_to and streamed_by and streaming_to == streamed_by:
		streaming_to = null
			
	#	--	STREAM MECHANICS
	if streaming_to and streaming_to in self.objs_map and self.disabled != true:
		if self.get_owner().was_my_turn == true:
			can_stream_be_active = true
		
		#	--
		var stream_target = self.objs_map[streaming_to]
		
		#	--	HITBOX LOGIC
		if is_instance_valid(hitbox_stream):
			if hitbox_stream.enabled == true:
				$"%Stream".default_color = lerp($"%Stream".default_color, stream_colors.Active, lerp_time)
				
			else:
				if can_stream_be_active == true:
					$"%Stream".default_color = lerp($"%Stream".default_color, stream_colors.Inactive, lerp_time)
				
				else:
					$"%Stream".default_color = lerp($"%Stream".default_color, stream_colors.Disabled, lerp_time)
				
				if hit_interval[0] < 1 and can_stream_be_active == true:
					hitbox_stream.activate()
				
			hitbox_stream.to_x = $"%Stream".points[1].x * self.get_facing_int()
			hitbox_stream.to_y = $"%Stream".points[1].y
			
				#	--	VISUAL LOGIC
		$"%Stream".width = lerp($"%Stream".width, 3, lerp_time)
		$"%Stream".points[1] = Vector2(int(stream_target.get_pos().x) - int(self.get_pos().x), int(stream_target.get_pos().y) - int(self.get_pos().y))
		
		$"%StreamStars".visible = true
		$"%StreamStars2".visible = true
		
		$"%StreamStars".position.x = $"%Stream".points[1].x / 2
		$"%StreamStars".position.y = $"%Stream".points[1].y / 2
		$"%StreamStars".emission_rect_extents.x = $"%Stream".points[1].x / 2
		$"%StreamStars".rotation_degrees = rad2deg($"%Stream".points[1].angle())
		
		$"%StreamStars2".position.x = $"%Stream".points[1].x / 2
		$"%StreamStars2".position.y = $"%Stream".points[1].y / 2
		$"%StreamStars2".emission_rect_extents.x = $"%Stream".points[1].x / 2
		$"%StreamStars2".rotation_degrees = rad2deg($"%Stream".points[1].angle())
		
		$"%StreamStars".emission_rect_extents.y = lerp($"%StreamStars".emission_rect_extents.y, $"%Stream".width, lerp_time)
		$"%StreamStars2".emission_rect_extents.y = lerp($"%StreamStars2".emission_rect_extents.y, $"%Stream".width, lerp_time)
			
		#	--	PROXIMITY LOCK
		if int(distance_to(stream_target)) > stream_distance:
			var vec = Vector2(stream_target.get_pos().x - self.get_pos().x, stream_target.get_pos().y - self.get_pos().y).normalized()
			
			self.apply_force(str(vec.x), str(vec.y))
			stream_target.apply_force(str(-vec.x), str(-vec.y))
		
	else:
		
		#	--	STREAM NONEXISTENT OR BROKEN
		$"%Stream".width = 0
		$"%Stream".default_color = stream_colors.Disabled
		
		$"%StreamStars".visible = false
		$"%StreamStars2".visible = false
		
		if is_instance_valid(hitbox_stream):
			if hitbox_stream.enabled == true:
				hitbox_stream.deactivate()
	
func _process(delta):
	._process(delta)
	
	#	--	INFO
	if is_instance_valid($"%Info"):
		$"%Info".visible = self.is_ghost
		$"%Info".bbcode_text = "[center]"
		
		if static_neuron == true: $"%Info".bbcode_text += "Static"
