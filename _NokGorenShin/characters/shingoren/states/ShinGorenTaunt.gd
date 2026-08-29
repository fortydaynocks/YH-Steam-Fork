extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	host.play_sound("1kDeaths_EndShort")
	host.gain_super_meter(300)
	$"%Stuff".unlock_achievement("SG-REVERSE-TAUNT")

func _tick():
	._tick()
	
	if current_tick >= 13:
		host.gain_super_meter(6)
