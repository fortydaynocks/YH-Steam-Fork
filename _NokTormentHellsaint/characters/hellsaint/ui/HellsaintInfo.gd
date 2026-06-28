extends PlayerInfo

#func set_fighter(fighter):
	#.set_fighter(fighter)
	#if player_id == 2:
		#$HBoxContainer.alignment = BoxContainer.ALIGN_END
		#$HBoxContainer.rect_position = Vector2(-299, 0)

#func _process(delta):
	#if is_instance_valid(fighter):
		#$"%Rune".rect_scale = Vector2(0.75, 0.75)
		
		#match fighter.rune:
			
			#"seeker":
			#	$"%Rune".texture = preload("res://_NokTormentHellsaint/characters/hellsaint/ui/thsui_display_seeker.png")
			#"death":
			#	$"%Rune".texture = preload("res://_NokTormentHellsaint/characters/hellsaint/ui/thsui_display_death.png")
			#"challenger":
			#	$"%Rune".texture = preload("res://_NokTormentHellsaint/characters/hellsaint/ui/thsui_display_challenger.png")
			#"blood":
			#	$"%Rune".texture = preload("res://_NokTormentHellsaint/characters/hellsaint/ui/thsui_display_blood.png")
			#"terminus":
			#	$"%Rune".texture = preload("res://_NokTormentHellsaint/characters/hellsaint/ui/thsui_display_terminus.png")
			#_:
			#	$"%Rune".texture = preload("res://_NokTormentHellsaint/characters/hellsaint/ui/thsui_display_empty.png")
