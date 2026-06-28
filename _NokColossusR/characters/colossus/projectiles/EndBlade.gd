extends "res://_NokColossusR/characters/colossus/projectiles/CSR-Projectile.gd"

var attack_primed = false
var attack_force = 20

var durability = [100, 100]

#	--	DURABILITY RULES
#	HITS GROUND		-10
#	HITS OPPONENT	-10
#	HITS WALL		-10
#	BLOCKED			-10
#	PARRIED			-20
#	BEEN HIT		-10
#	COLOSSUS HIT	-100

func prime():
	if self.current_state().state_name in ["Float", "Spin"]:
		attack_primed = true
		
		self.play_sound("Prime")
		self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(0, 0))
		
#	--
func on_got_blocked():
	.on_got_blocked()
	
	durability[0] -= 10
	
func on_got_parried():
	.on_got_parried()

	durability[0] -= 20
	
func hit_by(hitbox):
	.hit_by(hitbox)
	
	durability[0] -= 10

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == self.get_owner().opponent:
		durability[0] -= 10

#	--
func _process(delta):
	._process(delta)
	
	#	--	LABELS
	if is_instance_valid($"%Info") and self.disabled != true:
		$"%Info".visible = self.is_ghost
		$"%Info".bbcode_text = "[center]"
		
		$"%Info".bbcode_text += "[color=#686f99]Durablity: " + str(durability[0]) + " / " + str(durability[1])
		
func tick():
	.tick()
	
	var pos = self.get_pos()
	var opos = self.get_owner().opponent.get_pos()
	
	#	--
	var ocmu = self.get_owner().opponent.combo_moves_used
	var occ = self.get_owner().opponent.combo_count
	if occ > 0 and not (occ == 1 and len(ocmu) == 1 and ocmu.keys()[0] == "Burst"):
		durability[0] = 0
		
	if self.current_state().current_tick == 1:
		if self.current_state().state_name == "Slam":
			durability[0] -= 10
		
		if self.current_state().state_name == "Spin":
			durability[0] -= 10
	
	if durability[0] <= 0:
		self.screen_bump(Vector2(0, 0), 4, 0.25)
		self.play_sound("Break")
		
		self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Hit1.tscn"), Vector2(0, 0))
		self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Debris.tscn"), Vector2(0, 0))
		self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Debris.tscn"), Vector2(0, 0))
		self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Debris.tscn"), Vector2(0, 0))
		self.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Debris.tscn"), Vector2(0, 0))
		
		disable()
	
	#	--
	if attack_primed == true:
		if !self.current_state().state_name in ["Float", "Spin"]:
			attack_primed = false
			return
			
		if self.get_owner().was_my_turn == true or self.get_owner().opponent.was_my_turn == true:
			attack_primed = false
			
			var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
			
			self.change_state("Default")
			self.reset_momentum()
			self.apply_force(str(vec.x * attack_force), str(vec.y * attack_force))
