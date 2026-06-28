extends PlayerInfo

onready var ftex = $"%ForceTexture"

func set_fighter(fighter):
	.set_fighter(fighter)
	if player_id == 2:
		$"%HBoxContainer".alignment = BoxContainer.ALIGN_END
		$HBoxContainer.rect_position = Vector2(-31, 0)
		
func _process(delta):
	if is_instance_valid(fighter):
		
		match fighter.force_pips:
			
			0:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_0.png")
			1:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_1.png")
			2:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_2.png")
			3:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_3.png")
			4:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_4.png")
			5:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_5.png")
			6:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_6.png")
			7:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_7.png")
			_:
				$"%ForceTexture".texture = preload("res://_NokColossus/characters/colossus/ui/col_forceUI_0.png")
