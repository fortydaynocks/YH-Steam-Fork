extends Fighter

var tweens = {}

export (Dictionary) var objs_table
export (Dictionary) var vfx_table

var charname = "Snowdancer"
var last_values = {
	"opos": Vector2(0, 0)
}

var glaciation = {
	"value": 0,
	"last_value": 0,
	"max": 500,
	"threshold": 1.00,
	"base_threshold": 1.00,
	"climb_speed": 4,
	"drain_speed": 2,
	"snowflake_increase": 1.50,
}
var snowflakes = {
	"value": 0,
	"max": 4
}

var freeze = {
	"turns": 0,
	"max_turns": 5,
	"mul": 0.1,
	"max_mul": 0.9,
	"this_dmg": null,
	"total_dmg": 0
}

var elegant_storm = 0

#	============================================================================================== |
#	--	STATE GRANTING
func _enter_tree():
	._enter_tree()
	
	var parent = self.get_parent()
	
	if parent.name in ["Players"]:
		for plr in parent.get_children():
			if plr != self:
				grant_states(plr)
				
	parent.connect("child_entered_tree", self, "grant_states")

func grant_states(plr):
	grant_state(plr, $LoanedStates/Snowdancer_Frozen)
	grant_state(plr, $LoanedStates/Snowdancer_Blast)
	grant_state(plr, $LoanedStates/Snowdancer_Brace)
	grant_state(plr, $LoanedStates/Snowdancer_Shatter)

func grant_state(plr, state):
	for found_state in plr.get_node("StateMachine").get_children():
		if found_state.name == state.name:
			return
	
	var cloned_state = state.duplicate()
	
	plr.get_node("StateMachine").add_child(cloned_state)
	cloned_state.host = plr

#	============================================================================================== |
func construct_tween(tween_name):
	if tweens.has(tween_name): tweens[tween_name].kill()
	else: tweens[tween_name] = null

func quick_tween(tween_name, tween_type, object, parameter, target, time):
	if tweens.has(tween_name): tweens[tween_name].kill()
	else: tweens[tween_name] = null
	
	tweens[tween_name] = create_tween()
	
	var resultant_tween
	if tween_type == "tween_property":
		resultant_tween = tweens[tween_name].tween_property(object, parameter, target, time)


	return resultant_tween
	
func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)
	
func increment_glac(amount = 1):
	glaciation.value = clamp(glaciation.value + amount, 0, glaciation.max)
	
func increment_snowflakes(amount = 1, set = false):
	if set == true:
		snowflakes.value = clamp(amount, 0, snowflakes.max)
		
	else:
		snowflakes.value = clamp(snowflakes.value + amount, 0, snowflakes.max)
	
func freeze_opponent():
	if self.opponent.combo_count > 0: return
	if self.current_state().state_name in ["Grabbed"]: return
	if self.opponent.current_state().state_name in ["Grabbed"]: return
	
	glaciation.value = 0
	
	var opos = self.opponent.get_pos()
	
	self.spawn_particle_effect(preload("res://_NokSnowdancer/characters/snowdancer/effects/SD_Hit1.tscn"), Vector2(opos.x, opos.y + self.opponent.sprite.offset.y))
	self.play_sound("Freeze1")
	self.play_sound("Freeze2")
	
	self.opponent.change_state("Snowdancer_Frozen")
	
#	--	GLACIATION ON BLOCK
func on_got_blocked():
	.on_got_blocked()
	
	if self.current_state().get("glac_block"):
		increment_glac(self.current_state().glac_block)
	
# --
func _ready():
	._ready()
	
	if self.infinite_resources == true:
		snowflakes.value = snowflakes.max
	
func tick():
	.tick()
	
	#	--
	glaciation.threshold = glaciation.base_threshold + (glaciation.snowflake_increase * snowflakes.value)
	if elegant_storm > 0: glaciation.threshold + 2
	
	#	--	PASSIVE GLACIATION INCREMENTATION
	var pos = self.get_pos()
	var opos = Vector2(self.opponent.get_pos().x, self.opponent.get_pos().y)
	var dist = Vector2(last_values.opos.x - opos.x, last_values.opos.y - opos.y)
	
	if not self.current_state().state_name in ["Start"]:
		if not self.opponent.current_state().get("snowdancer_frozen"):
			var can_increment = false
			
			if dist.length() < glaciation.threshold and self.opponent.combo_count < 1:
				increment_glac(glaciation.climb_speed)
				
			else:
				if not self.opponent.current_state().state_name in ["Knockdown, HardKnockdown", "Getup"]:
					if self.combo_count < 1:
						if self.opponent.combo_count > 0 or glaciation.value < glaciation.max:
							increment_glac(-glaciation.drain_speed)
						
	#	--	FREEZE
	if glaciation.value >= glaciation.max:
		freeze_opponent()
		
	if self.opponent.current_state().get("snowdancer_frozen") != true:
		freeze.turns = 0
		freeze.total_dmg = 0
		freeze.mul = 0.1
		
	else:
		
		#	--	FREEZE HITTING
		if not freeze.this_dmg:
			for hbox in self.get_active_hitboxes():
				if hbox.overlaps(self.opponent.hurtbox):
					if self.opponent.current_state().get("brace") and hbox.start_tick in self.opponent.current_state().get("brace"):
						
						#	--	BRACED ICE HIT
						freeze.turns += 1
						
						self.hitlag_ticks = 10
						self.opponent.hitlag_ticks = 10
						
						self.apply_force_relative("-5", "0")
						self.opponent.apply_force_relative("-5", "0")
					
						self.rumble(2, 6)
						self.play_sound("FreezeBrace")
						self.play_sound("FreezeBrace2")
						self.spawn_particle_effect(preload("res://_NokSnowdancer/characters/snowdancer/effects/SD_BraceStar.tscn"), Vector2(pos.x + (hbox.x * self.get_facing_int()), pos.y + hbox.y))
						
						if freeze.turns >= freeze.max_turns:
							if freeze.total_dmg <= 0:
								if self.opponent.current_state().has_method("escape"):
									self.opponent.current_state().escape()
									self.change_state("ThrowTech")
							else:
								self.opponent.ex_effect(10)
								self.opponent.change_state("Snowdancer_Blast", int(freeze.total_dmg))
						
						hbox.deactivate()
						break
					
					else:
						
						#	--	SUCCESSFUL ICE HIT
						freeze.this_dmg = hbox.damage
						freeze.total_dmg += freeze.this_dmg * freeze.mul
						
						self.hitlag_ticks = 6
						self.opponent.hitlag_ticks = 6
						
						self.opponent.rumble(2, 6)
						self.play_sound("FreezeHit")
						self.play_sound("FreezeHit2")
						self.spawn_particle_effect(preload("res://_NokSnowdancer/characters/snowdancer/effects/SD_HitSlash.tscn"), Vector2(opos.x, opos.y + self.opponent.sprite.offset.y))
						
						hbox.deactivate()
						
						#	--
						if freeze.turns >= freeze.max_turns:
							if freeze.total_dmg > 0:
								self.opponent.ex_effect(10)
								self.opponent.change_state("Snowdancer_Blast", int(freeze.total_dmg))
						
						break
		
		#	--	FREEZE HITTING 2
		if self.was_my_turn:
			if freeze.this_dmg:
				freeze.mul = clamp(freeze.mul + 0.2, 0, freeze.max_mul)
			
			freeze.this_dmg = null
					
	#	--	ELEGANT STORM
	if elegant_storm >= 1:
		elegant_storm -= 1
			
	if elegant_storm <= 0 and snowflakes.value == snowflakes.max:
		elegant_storm = 1
		
	quick_tween("ElegantStormVFX", "tween_property", $"%ElegantStormVFX", "modulate", Color(1, 1, 1, 1) if elegant_storm >= 1 else Color(1, 1, 1, 0), 0.5)
	if is_instance_valid($"%ElegantStormSFX"):
		$"%ElegantStormSFX".volume_db = lerp($"%ElegantStormSFX".volume_db, -12 if elegant_storm >= 1 else -50, 0.075)
		
		if elegant_storm >= 1:
			if $"%ElegantStormSFX".playing == false:
				$"%ElegantStormSFX".playing = true
		else:
			if $"%ElegantStormSFX".volume_db < -40:
				$"%ElegantStormSFX".playing = false
	
	#	--	DISPLAYS
	if is_instance_valid($"%GlaciationDisplay"):
		$"%GlaciationDisplay".value = glaciation.value
		
		tweens.GlacDisplay = create_tween()
		
		if glaciation.value <= 0:
			tweens.GlacDisplay.tween_property($"%GlaciationDisplay", "modulate", Color(1, 1, 1, 0), 0.25)
		elif  glaciation.value == glaciation.max:
			tweens.GlacDisplay.tween_property($"%GlaciationDisplay", "modulate", Color(1, 1, 1, 1), 0.25)
		elif glaciation.last_value < glaciation.value:
			tweens.GlacDisplay.tween_property($"%GlaciationDisplay", "modulate", Color(1, 1, 1, 0.75), 0.25)
		else:
			tweens.GlacDisplay.tween_property($"%GlaciationDisplay", "modulate", Color(1, 1, 1, 0.25), 0.25)
	
	if is_instance_valid($"%GlaciationCount"):
		#$"%GlaciationCount".visible = self.is_ghost
		$"%GlaciationCount".bbcode_text = "[center]Glaciation: " + str(glaciation.value) + "\n[color=#AAFFFFFF]Threshold: " + str(glaciation.threshold) + "[/color]"
		if elegant_storm > 0: $"%GlaciationCount".append_bbcode("\n[color=#AAFFFFFF]Elegant Storm: " + str(elegant_storm) + "[/color]")
	
	if is_instance_valid($"%SnowflakeDisplay"):
		for child in $"%SnowflakeDisplay".get_children():
			child.visible = str(snowflakes.value) == child.name
	
	#	--
	last_values.opos = opos
	glaciation.last_value = glaciation.value
	
func _process(d):
	._process(d)
	
	
	self.opponent.sprite.self_modulate = Color(1, 1, 1)
	
	if float(glaciation.value) / float(glaciation.max) >= 0.5:
		self.opponent.sprite.self_modulate = lerp(Color(1, 1, 1), Color("80bfff"), ((float(glaciation.value) / float(glaciation.max)) * 2) - 1)
	
	if self.opponent.current_state().get("snowdancer_frozen") == true:
		self.opponent.sprite.self_modulate = Color("80bfff")
	
	#	--
	if float(glaciation.value) / float(glaciation.max) >= 0.75:
		self.opponent.rumble(0.3, 2)
		
	#	--	CASE POSITIONING
	var pos = self.get_pos()
	var opos = self.opponent.get_pos()
	
	$"%IceCase".visible = self.opponent.current_state() and self.opponent.current_state().get("snowdancer_frozen")
	$"%IceCase".position = Vector2(opos.x - pos.x, opos.y - pos.y)
	$"%IceCase".offset = self.opponent.sprite.offset

	#	--	INFO
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	$"%Info".bbcode_text += "[center]Glaciation: " + str(glaciation.value) + "\n"
	$"%Info".bbcode_text += "[color=#AAFFFFFF]Threshold: " + str(glaciation.threshold) + "[/color]\n"
	if elegant_storm > 0: $"%Info".bbcode_text += "[color=#AAFFFFFF]Elegant Storm: " + str(elegant_storm) + "[/color]"
	
	if freeze.turns > 0:
		$"%Info".bbcode_text += "\n[color=#80bfff]Frozen Turns Left: " + str(freeze.max_turns - (freeze.turns - 1)) + "\n"
		#$"%Info".bbcode_text += "Freeze MUL: " + str(freeze.mul) + "\n"
		#$"%Info".bbcode_text += "Freeze DMG: " + str(freeze.this_dmg) + "\n"
		$"%Info".bbcode_text += "Total DMG: " + str(freeze.total_dmg) + "[/color]\n"
