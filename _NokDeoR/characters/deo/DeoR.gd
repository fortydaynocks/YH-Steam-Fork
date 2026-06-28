extends Fighter

export (Dictionary) var objs_table
export (Dictionary) var vfx_table
export (Dictionary) var colors_table
var tweens = {
	"HelperTween": null,
}

var charname = "Deo"
var turn_passed = false

var stand = null
enum stand_requirements {
	Any,
	Off,
	On,
	OnStand,
	OnFollow,
}

var stand_values = {
	"Stand": null,
	"Pilot": null
}

#	ENTITY: DAYS_LEFT
var timestop_time = 0
var timestop_spread_distance = 100
var stopped_entities = {
	
}

# ----------------------------------------------------------------------------------------------
func play_voiceline(sound):
	var container = self.get_node("Sounds")
	var chosen_sound = self.randi_choice(sound.audio)
	
	if chosen_sound != null:
		$"%Voiceline".volume_db = sound.volume
		$"%Voiceline".pitch_scale_ = float(sound.pitch)
		$"%Voiceline".pitch_variation = sound.variation
		$"%Voiceline".stream = chosen_sound
		
		self.play_sound("Voiceline")
		
func voiceline(sound):
	var container = self.get_node("Sounds")
	
	$"%Voiceline".volume_db = -6
	$"%Voiceline".pitch_scale_ = 1
	$"%Voiceline".pitch_variation = 0.025
	$"%Voiceline".stream = sound
	
	self.play_sound("Voiceline")
	
# ----------------------------------------------------------------------------------------------
func summon_stand():
	var stand_obj = self.spawn_object(objs_table.Stand, 18, -9, true, null, true)
		
	stand_obj.set_grounded(false)
	stand_obj.sprite.material = self.sprite.material
	
	stand_values.Stand = stand_obj.obj_name
	
	self.play_sound("Summon")
	self.play_sound("SummonVoice")
	self.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Ring1.tscn"), Vector2(0, -18))
	
func unsummon_stand():
	if stand_values.Stand and is_instance_valid(obj_from_name(stand_values.Stand)):
		obj_from_name(stand_values.Stand).change_state("Callback")
	
func has_stand():
	pass
	
func get_stand():
	if stand:
		var stand_obj = self.objs_map[stand]; if is_instance_valid(stand_obj):
			return stand_obj
			
	return false
	
#	--
func stand_action(stand_action):
	var pilot = Vector2(self.current_di.x, self.current_di.y)
	if pilot.length() <= 0: pilot = null
	
	if not (stand_values.Stand or is_instance_valid(obj_from_name(stand_values.Stand))):
		summon_stand()
	
	self.obj_from_name(stand_values.Stand).queue_action(stand_action, pilot)
	
func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)
	
	
#	--
func stop_entity(obj, time = 10, type = "Normal", forced = false):
	if stopped_entities.get(obj.obj_name) and (not forced): return
	
	if timestop_time <= 0:
		timestop_time = time
	
	#	--
	stopped_entities[obj.obj_name] = {
		"type": type,
		"anchor_position": obj.get_pos(),
		"exit_velocity": obj.get_vel(),
		}
	
	#	--
	obj.reset_momentum()
	obj.get_node("Flip").modulate = Color(0.33, 0.33, 0.33)
	obj.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-KnifeShine.tscn"),
	Vector2(obj.hurtbox.x, obj.hurtbox.y))
	
	if obj.is_in_group("Fighter"):
		obj.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Warning.tscn"), Vector2(0, -18))
		
		if self.combo_count >= 1:
			obj.hitlag_ticks = 6
			
	if obj.has_method("timestopped"):
		obj.timestopped()
	
func free_entity(key):
	var obj = self.obj_from_name(key)
	var values = stopped_entities.get(key)
	
	if obj:
		obj.reset_momentum()
		obj.apply_force(str(values.exit_velocity.x), str(values.exit_velocity.y))
		obj.get_node("Flip").modulate = Color(1, 1, 1)
		obj.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-TimestopFreed.tscn"),
		Vector2(obj.hurtbox.x, obj.hurtbox.y))
		
		stopped_entities.erase(key)
	#if values:
		
func free_opponent():
	for entity in stopped_entities.keys():
		if entity == self.opponent.obj_name:
			free_entity(entity)
	
func is_timestopped(entity):
	return entity in stopped_entities.keys()
	
func spread_timestop(entity):
	var obj = self.obj_from_name(entity)
	
	if is_instance_valid(obj) and (not is_timestopped(obj)):
		for target in self.objs_map.values():
			if is_instance_valid(target) and (not target.disabled) and(not target.is_in_group("Fighter")) and (not "NoTimestop" in target.editor_description):
				if int(obj.distance_to(target)) <= timestop_spread_distance and target.current_tick > 1:
					stop_entity(target, timestop_time, "Normal")
	
# ---------------------------------------------------------------------------- |
func super_effect(freeze_ticks = 0):
	.super_effect(freeze_ticks)
	
	self.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Super.tscn"),
	Vector2(0, -18))

func process_extra(extra):
	.process_extra(extra)
	
	stand_values.Pilot = extra.get("StandPilot")
	
	if stand and extra.StandAction:
		var stand_obj = self.objs_map[stand]; if is_instance_valid(stand_obj):
			var requested_state = stand_obj.state_machine.states_map[extra.StandAction]; if requested_state:
				if requested_state.get("instant_action") == true:
					stand_obj.change_state(extra.StandAction, extra.StandActionData)
				else:
					stand_obj.buffer_action = [extra.StandAction, extra.StandActionData]
					stand_obj.buffer_made_this_turn = true
	
func on_got_hit():
	.on_got_hit()
	
	free_opponent()
		
func on_got_parried():
	.on_got_parried()
	
	free_opponent()
	
func on_state_changed(states_stack):
	.on_state_changed(states_stack)
	
	if self.stance == "Knives":
		self.change_stance_to("Normal")
	
# ---------------------------------------------------------------------------- |
func init(pos = null):
	.init(pos)
	
	melee_attack_combo_scaling_applied = false

func tick_before():
	.tick_before()
	
	turn_passed = false
	if self.was_my_turn or self.opponent.was_my_turn: turn_passed = true
	elif self.turn_frames == 0 or self.opponent.turn_frames == 0: turn_passed = true

func tick():
	.tick()
	
	#	--
	timestop_time = int(clamp(timestop_time - 1, 0, INF))
	
	for entity in stopped_entities.keys():
		var obj = self.obj_from_name(entity)
		var values = stopped_entities[entity]
		
		if obj:
			if timestop_time <= 0:
				free_entity(entity)
			else:
				if timestop_time % 10 == 0:
					if values.type == "Spread":
						obj.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-TimestopProcess2.tscn"),
						Vector2(obj.hurtbox.x, obj.hurtbox.y))
					else:
						obj.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-TimestopProcess.tscn"),
						Vector2(obj.hurtbox.x, obj.hurtbox.y))
						
	#	--	TIMESTOP
	for entity in stopped_entities.keys():
		var obj = self.obj_from_name(entity)
		var values = stopped_entities[entity]
		
		if values.type == "Spread":
			spread_timestop(entity)
		
		if obj and (not obj.current_state().state_name in ["Grabbed"]):
			#obj.set_pos(str(obj.get_pos().x), str(obj.get_pos().y))
			if self.combo_count > 0:
				values.anchor_position = obj.get_pos()
			obj.set_pos(str(values.anchor_position.x), str(values.anchor_position.y))
			obj.set_vel("0", "0")
			
			if (not obj.is_in_group("Fighter")):
				obj.hitlag_ticks += 1
