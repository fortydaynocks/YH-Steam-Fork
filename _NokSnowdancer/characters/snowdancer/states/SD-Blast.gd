extends CharacterState

var snowdancer_frozen = true

func _enter():
	._enter()
	
	host.opponent.visible_combo_count += 1
	host.start_invulnerability()

func _frame_1():
	if data and data is int:
		host.take_damage(data)
	
	host.rumble(8, 10)
	
	host.opponent.play_sound("Blast")
	host.opponent.play_sound("Blast2")
	host.opponent.play_sound("Blast3")
	
	host.change_state("ThrowTech")
	host.apply_force_relative("-12", "-4")
	
	
