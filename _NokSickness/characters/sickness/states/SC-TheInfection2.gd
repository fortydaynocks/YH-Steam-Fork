extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

onready var hbox_ball = $HitboxBall
onready var hbox_slash = $HitboxSlash

func _exit():
	._exit()
	
	host.opponent.flip.visible = true

func try_play_hbox_sounds(hbox):
	if is_instance_valid(hbox):
		if hbox.hit_sound_player and hbox.hit_bass_sound_player and (not ReplayManager.resimulating):
			hbox.hit_sound_player.play()
			hbox.hit_bass_sound_player.play()

func _frame_35():
	host.increment_property(host.disease, host.illness.value)
	host.increment_property(host.illness, -host.illness.value)

func _tick():
	._tick()
	
	if current_tick > 35:
		host.global_hitlag(1)
	
	#	--	8 DAMAGE
	if current_tick in [1, 3, 5, 7, 9, 11, 13, 15]:
		
		#host.opponent.take_damage(1)
		
		if is_instance_valid(hbox_ball):
			host.opponent.launched_by(hbox_ball.to_data())
			try_play_hbox_sounds(hbox_ball)
			
			#hbox_ball.hit_sound_player.play()
			#hbox_ball.hit_bass_sound_player.play()
			
	if current_tick == 17:
		host.opponent.flip.visible = false

		if is_instance_valid(hbox_slash):
			host.opponent.launched_by(hbox_slash.to_data())
			try_play_hbox_sounds(hbox_slash)
			
	if current_tick == 35:
		host.opponent.flip.visible = true
			
	if current_tick in [36, 44, 52]:
		host.play_sound("LaughByte")
		
