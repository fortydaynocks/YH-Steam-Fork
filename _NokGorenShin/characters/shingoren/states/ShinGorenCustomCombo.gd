extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _enter():
	._enter()
	
	if host.combo_count >= 1:
		host.start_invulnerability()
		
	if host.skin == 2:
		host.play_sound("AK_CCStart")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		host.ccs_in_combo += 1
		
		if host.ccs_in_combo >= 3:
			$"%Stuff".unlock_achievement("SG-3CC")

func _tick():
	._tick()
	
	if current_tick <= 9:
		host.global_hitlag(1)
	
func _frame_10():
	host.cc = true
	
	#	--
	if host.skin == 0:
		host.play_sound("LetsGo")
	
	host.play_sound("FireBlast")
	
	if host.skin == 1:
		pass
		#host.play_sound("AK_CC" + str(host.randi_range(1, 4)))
