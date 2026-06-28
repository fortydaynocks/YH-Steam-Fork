extends Fighter

var buffers = {
	"slumber": true
}

var charname = "Durmak"

var bleed = {
	"turns": 0,
	"limit": 12,
	"dmg": 3,
	"cripple": false,
	"cripple_speed_limit": 8,
}

var slumber = {
	"min_frame": 3
}

var walker_limit = 1
var lord_reference = preload("res://_NokDurmak/characters/durmak/summons/LordWalker.tscn")

#	--
#func _process(d):
	#._process(d)
	
	#var main_scene = get_tree().get_current_scene()
	#var buttons = main_scene.get_node("%P1ActionButtons") if self.id == 1 else main_scene.get_node("%P2ActionButtons")
	
	#if (not ReplayManager.resimulating) and buttons.locked_in == false:
		#buttons._on_submit_pressed()

#	--
func global_hitlag(amount, force = false):
	.global_hitlag(amount, true)

	#	--	mfs who have [enable hit freeze frames] off earn no prizes from me

#	--
func _enter_tree():
	._enter_tree()
	
	var fx = AudioServer.get_bus_index("Fx")
	
#	============================================================================================== |
func cripple():
	if bleed.cripple: return
	
	bleed.cripple = true
	
	var opos = self.opponent.get_pos()
	self.play_sound("concussion-short")
	self.spawn_particle_effect(preload("res://_NokDurmak/characters/durmak/effects/DM-Red.tscn"), Vector2(opos.x, opos.y - 18))

func can_block_cancel():
	if buffers.slumber:
		for obj in self.objs_map.values():
			if is_instance_valid(obj) and (not obj.disabled) and obj.creator == self and obj.get("tag") == "Slumber":
				if obj.hurtbox.overlaps(self.hurtbox):
					return false
	
	return .can_block_cancel()
	
func slumber():
	if self.current_di.y < 0:
		self.change_state("slumberswingH")
	else:
		if self.current_di.y > 0:
			self.change_state("slumberswingA")
			
		else:
			self.change_state("slumberswing")

#	============================================================================================== |

func process_extra(extra):
	.process_extra(extra)
		
	buffers.slumber = extra.Slumber

func tick():
	.tick()
	
	var pos = self.get_pos()
	var opos = self.opponent.get_pos()
	
	#	--
	if self.opponent.combo_count > 0: bleed.turns = 0
	if self.opponent.parried: bleed.turns = 0
	bleed.turns = clamp(bleed.turns, 0, bleed.limit)
	
	#	--	CRIPPLE
	if bleed.cripple:
		if bleed.turns <= 0:
			bleed.cripple = false
			
		else:
			
			#	--	CRIPPLE PROCESSES
			var antiforce = -1 if int(self.opponent.get_vel().x) > 0 else 1
			if abs(int(self.opponent.get_vel().x)) < 1: antiforce = 0
			
			self.opponent.apply_force(str(0.25 * antiforce), "0")
			self.opponent.air_movements_left = 0
	
	#	--	TURN PROCESSES
	if self.was_my_turn or self.opponent.was_my_turn:
		if bleed.turns > 0:
			if self.opponent.hp - bleed.dmg > 0:
				self.opponent.take_damage(bleed.dmg)
				self.opponent.rumble(0.5, 5)
			
			self.spawn_particle_effect(preload("res://_NokDurmak/characters/durmak/effects/DM-Bleed.tscn"), Vector2(opos.x, opos.y - 18))
		
			#	--	CRIPPLE BLOCKSTUN
			if bleed.cripple:
				var exclusions = ["Knockdown", "HardKnockdown", "Getup"]
				if (not self.opponent.current_state().state_name in exclusions) and self.opponent.blocked_hitbox_plus_frames == 0:
					self.opponent.blocked_hitbox_plus_frames = 1
		
		#	--
		bleed.turns = clamp(bleed.turns - 1, 0, INF)
		
	#	--	SLUMBER
	if buffers.slumber and (not self.opponent.current_state().state_name in ["Grabbed"]):
		for obj in self.objs_map.values():
			if is_instance_valid(obj) and (not obj.disabled) and obj.creator == self and obj.get("tag") == "Slumber":
				if obj.hurtbox.overlaps(self.hurtbox):
					
					var cstate = self.current_state()
					var exclusions = ["Knockdown", "HardKnockdown", "Getup"]
					if self.opponent.combo_count < 1 and (not cstate.type in [4, 5]) and (not cstate.state_name in exclusions) and (not "NoSlumber" in cstate.editor_description):
						var post_hitbox_frame = 0
						
						for hbox in cstate.get_children():
							if hbox is Hitbox:
								if hbox.start_tick > post_hitbox_frame:
									post_hitbox_frame = hbox.start_tick
						
						if cstate.current_tick >= slumber.min_frame and cstate.current_tick >= post_hitbox_frame:
							slumber()
							
							obj.play_sound("SlumberActiv")
							obj.disable()
		
func _process(d):
	._process(d)
	
	#	--	INFO DISPLAY
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	if bleed.turns > 0: $"%Info".bbcode_text += "[color=#ff0000]Bleeding: " + str(bleed.turns) + "[/color]\n"
	if bleed.cripple: $"%Info".bbcode_text += "[color=#ff8f8f]CRIPPLED\n"
	
	self.opponent.sprite.self_modulate = Color(1, 1, 1)
	if bleed.cripple: self.opponent.sprite.self_modulate = Color(0.75, 0.25, 0.25)
	
	#	--
	var pos = self.get_pos()
	var opos = self.opponent.get_pos()
	
	$"%BloodOverlay".offset = self.sprite.offset
	$"%BloodOverlay".flip_h = self.get_facing_int() == -1
	$"%BloodOverlay".texture = self.sprite.frames.get_frame(self.sprite.animation, self.sprite.frame)

	$"%BloodOverlay2".offset = Vector2(opos.x - pos.x, opos.y - pos.y) + self.opponent.sprite.offset
	$"%BloodOverlay2".flip_h = self.opponent.get_facing_int() == -1
	$"%BloodOverlay2".texture = self.opponent.sprite.frames.get_frame(self.opponent.sprite.animation, self.opponent.sprite.frame)
