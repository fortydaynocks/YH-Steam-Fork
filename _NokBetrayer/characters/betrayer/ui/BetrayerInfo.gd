extends PlayerInfo

"""
func _process(delta):
	if is_instance_valid(self.fighter):
		
		#	--
		if self.fighter.id == 1:
			display.rect_position = Vector2(46, 30)
			
		elif self.fighter.id == 2:
			display.rect_position = Vector2(230, 30)

		#	--	NOTCH VISIBILITY
		for blade_name in fighter.blades.keys():
			var blade_value = fighter.blades[blade_name]
			
			var notch = display.get_node("Notch" + blade_name); if notch:
				if notch.texture.region.position.x == 0 and blade_value == true:
					notch.get_node("hit").emitting = true
					notch.get_node("slash").emitting = true
				
				if blade_value == true:
					notch.texture.region.position.x = 7
					
				else:
					notch.texture.region.position.x = 0
		
		#	--	EYE VISIBILITY
		var arbitary_number = 0
		
		if fighter.blades.Justice == true and fighter.judgement_mode == true:
			arbitary_number = 17
		elif fighter.blades.Justice == true:	
			arbitary_number = 13	
		
		if eye.texture.region.position.x < arbitary_number:
			eye.get_node("hit").emitting = true
			eye.get_node("slash").emitting = true
		
		eye.texture.region.position.x = arbitary_number
"""
