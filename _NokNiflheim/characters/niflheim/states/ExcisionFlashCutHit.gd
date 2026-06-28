extends CharacterState

export (PackedScene) var chain_projectile
export (PackedScene) var end_projectile

func _enter():
	host.start_invulnerability()
	host.opponent.start_invulnerability()
	
func _exit():
	host.end_invulnerability()
	host.opponent.end_invulnerability()

func _tick():
	if current_tick >= 30 and current_tick < 46 and current_tick % 2 == 0:
		host.play_sound("EFCWhoosh")
	
	if current_tick == 46:
		host.opponent.end_invulnerability()
	
	if current_tick >= 48 and current_tick < 76 and current_tick % 2 == 0:
		var opos = host.opponent.get_pos()
		
		host.spawn_object(chain_projectile, opos.x, opos.y + 24, false, null, false)
		
	if current_tick == 76:
		var opos = host.opponent.get_pos()
		
		host.spawn_object(end_projectile, opos.x, opos.y + 24, false, null, false)
