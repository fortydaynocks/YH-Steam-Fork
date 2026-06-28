extends "res://_NokPsychoR/characters/psycho/projectiles/PsychoProjectile.gd"

var stain_type = "Stain"
var clean_strike_threshold = 70

var lifetime = 90

func activate_stain():
	match stain_type:
		"Stain":
			self.disable()
		
		"Bloodstain":		
			self.change_state("Bloodstain")
			
		"Bloodwash":
			self.change_state("Bloodwash")
			
		_:
			self.disable()

func tick():
	.tick()
	
	if self.is_ghost:
		$"%GhostMarker".visible = true
		$"%Info".visible = true
		
		$"%Info".bbcode_text = "[center]Type: " + stain_type
		if stain_type == "Stain":
			var pos = self.get_pos()
			var opos = self.get_owner().opponent.get_pos()
			var length = Vector2(opos.x - pos.x, opos.y - pos.y).length()
			if length <= clean_strike_threshold:
				$"%Info".bbcode_text += "\n[color=#FF0000] Distance: " + str(round(length)) + "[/color]"
				
			else:
				$"%Info".bbcode_text += "\n Distance: " + str(round(length))

	if self.current_tick >= lifetime and self.current_state().state_name == "Default":
		self.disable()
	
