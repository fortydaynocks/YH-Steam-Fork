extends CharacterState

export (int) var _c_colossus
export (int) var armor_start_tick = -1
export (int) var armor_end_tick = -1
export (bool) var force_proration_penalty = false
export (bool) var increment_sword_moves = false

export (Dictionary) var fire_placement

onready var install_fire = preload("res://_NokColossus/characters/colossus/projectiles/HolyGhostFire.tscn")

func _enter():
	._enter()
	
	if armor_start_tick == 0:
		if host.force_pips > 0:
			host.force_armor = true
	
	#if force_proration_penalty == true:
		#host.refresh_hitboxes()
		
		#for hitbox in host.hitboxes:
			#hitbox.damage_proration = 2 + host.force_pips
		
	#for hitbox in host.hitboxes:
		#hitbox.damage_proration = host.force_pips

func _tick():
	._tick()
	
	if current_tick == armor_start_tick:
		if host.force_pips > 0:
			host.force_armor = true
		if host.force_pips >= 7:
			host.start_throw_invulnerability()
			
	if current_tick == armor_end_tick:
		host.force_armor = false
		host.end_throw_invulnerability()
		
	#	--
	
	if host.aston == true:
		if host.is_grounded() == true:
			for value in fire_placement.keys():
				if value == current_tick:
					for value2 in fire_placement[current_tick]:
						host.spawn_object(install_fire, value2.x, value2.y, true, null, true)

func _exit():
	._exit()
	
	host.force_armor = false
	host.end_throw_invulnerability()

#	---------------------------------------------------------------------------------------------------------------------
#	SKIN STUFF

var ak_sfx_player = null
func make_skin_audio(vol, sfx):
	ak_sfx_player = VariableSound2D.new()
	add_child(ak_sfx_player)
	ak_sfx_player.bus = "Fx"
	ak_sfx_player.stream = sfx
	ak_sfx_player.volume_db = vol
	
	ak_sfx_player.play()
		

func init():
	if host.skin == 1:
		for hitbox in self.get_children():
			
			#	--	HIT SOUNDS
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/hit1_weak.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleeweak.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/Impact_Ground_02.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleeweak.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/hit1_mid.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleemid.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/Impact_Ground_03.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleemid.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/hit1_strong.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleestrong.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/hit1_insane.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleeinsane.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/bigmetalhit.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_hitheavy.wav")
			
			#	--	HIT BASS SOUNDS
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/hit1_weak.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleeweak.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/Impact_Ground_02.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleeweak.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/hit1_mid.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleemid.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/Impact_Ground_03.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleemid.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/hit1_strong.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_meleestrong.wav")
			if hitbox.hit_sound == preload("res://_NokColossus/characters/colossus/sounds/bigmetalhit.wav"):
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_hitheavy.wav")
	
		#	--	SWING SOUNDS
		if enter_sfx == preload("res://_NokColossus/characters/colossus/sounds/P_Whoosh_Hurricane_01.wav"):
			enter_sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing1.wav")
		if enter_sfx == preload("res://_NokColossus/characters/colossus/sounds/P_Whoosh_Hurricane_05.wav"):
			enter_sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing2.wav")
		if enter_sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING02.wav"):
			enter_sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing1.wav")
		if enter_sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING03.wav"):
			enter_sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing2.wav")
		if enter_sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING04.wav"):
			enter_sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing3.wav")
		if enter_sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING05.wav"):
			enter_sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing4.wav")
		if enter_sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING06.wav"):
			enter_sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing5.wav")
			
		if sfx == preload("res://_NokColossus/characters/colossus/sounds/P_Whoosh_Hurricane_01.wav"):
			sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing1.wav")
		if sfx == preload("res://_NokColossus/characters/colossus/sounds/P_Whoosh_Hurricane_05.wav"):
			sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing2.wav")
		if sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING02.wav"):
			sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing1.wav")
		if sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING03.wav"):
			sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing2.wav")
		if sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING04.wav"):
			sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing3.wav")
		if sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING05.wav"):
			sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing4.wav")
		if sfx == preload("res://_NokColossus/characters/colossus/sounds/SWING06.wav"):
			sfx = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_swing5.wav")

		#	--	FORCED SOUND REPLACEMENTS
		
		if "fullcircle" in self.name:
			for hitbox in self.get_children():
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_slash1.wav")
		
		if "stratoscleave" in self.name:
			for hitbox in self.get_children():
				hitbox.hit_bass_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_slash3.wav")
		
		if "heavyoverhead" in self.name:
			for hitbox in self.get_children():
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_slash2.wav")
			
		if "groundsweeper" in self.name:
			for hitbox in self.get_children():
				hitbox.hit_sound = preload("res://_NokColossus/characters/colossus/skins/astaroth/sounds/asta_slash1.wav")	
	.init()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)

	if increment_sword_moves == true:
		host.sword_attacks_used[0] += 1
		
		if host.sword_attacks_used[0] >= host.sword_attacks_used[1]:
			host.global_hitlag(8)
			host.play_sound("SwordWarning")
			
			host.add_pushback("-10")
			host.opponent.add_pushback("-10")
