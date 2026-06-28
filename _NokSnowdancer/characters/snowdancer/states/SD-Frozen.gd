extends CharacterState

var snowdancer_frozen = true

func escape():
	var pos = host.get_pos()
	
	host.change_state("ThrowTech")
	host.apply_force_relative("-8", "0")
	
	host.opponent.spawn_particle_effect(preload("res://_NokSnowdancer/characters/snowdancer/effects/SD_Hit1.tscn"), Vector2(pos.x, pos.y + host.sprite.offset.y))
	host.opponent.play_sound("Unfreeze")
	host.opponent.play_sound("Unfreeze2")
	return
				
func _enter():
	._enter()
	
	var pos = host.get_pos()
	
	#	--
	if self._previous_state() and self._previous_state().get("snowdancer_frozen"):
		host.opponent.freeze.turns += 1 
			
		if host.opponent.freeze.turns > host.opponent.freeze.max_turns:
			if host.opponent.freeze.total_dmg > 0:
				host.change_state("Snowdancer_Blast", int(host.opponent.freeze.total_dmg))
				return
				
			else:
				escape()
				return
				
func _frame_0():
	host.start_invulnerability()
	
func on_continue():
	.on_continue()
	
	
