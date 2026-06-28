extends ThrowState

export (int) var _c_skins
export (Array, Resource) var akuma_voicelines

func _tick():
	._tick()
	
	if current_tick <= 6:
		host.hitlag_ticks = 1
		
	#	--
	if host.skin == 1:
		for vl in akuma_voicelines:
			if vl.tick == current_tick:
				host.play_voiceline(vl)
