extends CharacterState

export var _c_drag = 0
export (bool) var drag = false
export (int) var offset_x = 0
export (int) var offset_y = 0
export (int) var start_on = 1
export (int) var end_on = 1
export (float) var drag_strength = 2.5
export (bool) var force_drag = false

export var _c_colossus = 0
export (int) var fastfall_adjustment = 0
export (bool) var can_armor = false
export (int) var armor_start = -1
export (int) var armor_end = -1
export (int) var force_block_frame = -1
export (int) var force_block_dist = 120
export (int) var minimum_flames = 0
export (int) var consume_flames = 0
export (float) var hit_flamestain = 0
export (float) var block_flamestain = 0
export (bool) var dont_burn_during = false

var armor_hit_this_frame = false
var has_super_clashed = false
var force_end_armor = false
var has_granted_flamestain = false
var used_armor_this_turn = false
var armor_interrupted = false

#	--
func is_usable():
	var condition = true
	
	if host.current_special_stance == "Sword" and "ReqFlame" in self.editor_description:
		condition = false
		
	if host.current_special_stance == "Flame" and "ReqSword" in self.editor_description:
		condition = false
	
	return .is_usable() and condition and host.lordflame.Value >= minimum_flames

#	--
func _enter():
	._enter()
	
	has_granted_flamestain = false
	force_end_armor = true
	used_armor_this_turn = false
	armor_interrupted = false
	
	if host.buffer_armor == true and host.fortitude.Value >= host.fortitude.ArmorCost:
		host.fortitude.Value -= host.fortitude.ArmorCost
		
		host.buffer_armor = false
		force_end_armor = false
		used_armor_this_turn = true
	
	host.hits_with_armor.Opponent = 0
	host.hits_with_armor.Projectile = 0

	if consume_flames >= 1:
		host.lordflame.Value -= consume_flames

func on_continue():
	.on_continue()
	
	if can_armor and self.feinting and host.hits_with_armor.Opponent > 0:
		armor_interrupted = true

func _tick():
	._tick()
	
	armor_hit_this_frame = false
	
	#	--	DRAG
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))

	#	--	ARMOR ALLOWANCE
	if current_tick >= armor_start and current_tick < armor_end and force_end_armor != true:
		host.has_hyper_armor = true
		
	else:
		host.has_hyper_armor = false
		
		if current_tick == armor_end:
			host.end_invulnerability()
	
	#	--	ARMOR FUNCTIONALITY
	if host.has_hyper_armor == true and current_tick < armor_end:
		host.start_invulnerability()
		
		if armor_hit_this_frame == false:
			for hostile_obj in host.objs_map.values():
				if is_instance_valid(hostile_obj) and hostile_obj.get_owner() != host:
					for hostile_hitbox in hostile_obj.get_active_hitboxes():
						if hostile_hitbox is Hitbox and (not hostile_hitbox.hitbox_type in [6]) and hostile_hitbox.overlaps(host.hurtbox):
							if hostile_obj is Fighter:
								if hostile_hitbox.guard_break == true or hostile_hitbox is ThrowBox:
									host.has_hyper_armor = false
									host.end_invulnerability()
									
									if hostile_hitbox.guard_break == true:
										host.guard_broken_this_turn = true
										host.armor_broken_this_turn = true
										
										host.global_hitlag(24)
										host.screen_bump(Vector2(0, 0), 16, 0.1)
										
										host.play_sound("ArmorBreak")
										host.play_sound("ArmorBreak2")
										host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-HitSlash.tscn"), Vector2(0, -18))
									
								else:
									on_armor_hit("Opponent")
									host.take_damage(hostile_hitbox.damage) if (host.hits_with_armor.Opponent <= 0 and host.hits_with_armor.Projectile <= 0) else host.take_damage(15)
									#host.take_damage(hostile_hitbox.damage / 2)
									hostile_hitbox.deactivate()
								
							else:
								on_armor_hit("Projectile")
								host.take_damage(hostile_hitbox.damage) if (host.hits_with_armor.Opponent <= 0 and host.hits_with_armor.Projectile <= 0) else host.take_damage(15)
								#host.take_damage(hostile_hitbox.damage / 2)
								#hostile_hitbox.deactivate()
								if hostile_obj.current_state().has_method("fizzle"):
									hostile_obj.current_state().fizzle()
								else:
									hostile_obj.disable()
								
	if (current_tick >= force_block_frame and current_tick < armor_end + 1) and (host.hits_with_armor.Opponent > 0 or host.hits_with_armor.Projectile > 0):
		if host.hits_with_armor.Opponent > 0 and int(host.distance_to(host.opponent)) <= force_block_dist:
			if not armor_interrupted:
				host.opponent.initiative = false
				host.opponent.change_state("ParryAuto")

func on_armor_hit(type):
	host.screen_bump(Vector2(0, 0), 8, 0.1)
	if is_instance_valid($"%ClashShine"):
		$"%ClashShine".texture = host.sprite.frames.get_frame(host.sprite.animation, host.sprite.frame)
		$"%ClashShine".restart()
		$"%ClashShine".emitting = true
	
	host.play_sound("ArmorHit")
	host.spawn_particle_effect_relative(preload("res://fx/FlawedParryEffect.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://fx/WallSlamEffect.tscn"), Vector2(0, -18), Vector2(-host.get_facing_int(), 0))
	
	if type == "Opponent":
		host.hits_with_armor.Opponent += 1
		armor_hit_this_frame = true
		
	if type == "Projectile":
		host.hits_with_armor.Projectile += 1
		
	host.global_hitlag(12)	

func on_got_blocked():
	.on_got_blocked()
	
	#	GET ALL CURRENTLY HITBOXES OVERLAPPING W/ THE OPPONENT.
	#	ONLY PROCEEDS WITH THE CLASH IF NONE OF THEM CAN CAUSE A CLASH.
	
	#if host.hits_with_armor.Opponent < 1 and host.hits_with_armor.Projectile < 1 and used_armor_this_turn == true:
		#host.opponent.blocked_hitbox_plus_frames -= 1
	
	if has_super_clashed == false:
		var can_clash = true
		
		for hbox in host.get_active_hitboxes():
			if can_clash == true and hbox.overlaps(host.opponent.hurtbox):
				if hbox.hitbox_type == 6 or "CannotSC" in hbox.misc_data:
					can_clash = false
			
		if can_clash == true:
			if host.hits_with_armor.Opponent > 0 or host.hits_with_armor.Projectile > 0:
				host.end_invulnerability()
				
				host.play_sound("SuperClash")
				host.play_sound("SuperClash2")
				
				host.screen_bump(Vector2(0, 0), 12, 0.25)
				host.opponent.spawn_particle_effect_relative(preload("res://fx/WallSlamEffect.tscn"), Vector2(0, -18), Vector2(-host.opponent.get_facing_int(), 0))
				host.opponent.apply_force_relative("-3", "0")
				
				var total_times_hit = host.hits_with_armor.Opponent + host.hits_with_armor.Projectile
				
				#	--	REWARDS
				host.gain_super_meter(20 * total_times_hit)
				
				for hitbox in get_active_hitboxes():
					if host.opponent.hp - hitbox.damage / 5 < 0:
						host.opponent.hp = 1
					else:
						host.opponent.take_damage(hitbox.damage / 5)
				
				host.global_hitlag(6)
		
func on_got_perfect_parried():
	.on_got_perfect_parried()
	
	force_end_armor = true
	
