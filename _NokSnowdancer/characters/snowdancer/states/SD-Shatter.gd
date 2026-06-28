extends "res://_NokSnowdancer/characters/snowdancer/states/SD-Frozen.gd"

func _enter():
	._enter()
	
	self.anim_name = "InstantCancel"
	
	if host.opponent.get("charname") == "Snowdancer":
		host.opponent.get_node("IceCase").visible = true
	
func _frame_0():
	host.start_invulnerability()
	snowdancer_frozen = true
	
func _frame_2():
	snowdancer_frozen = false
	self.anim_name = "Burst"
	
func _frame_14():
	host.end_invulnerability()
