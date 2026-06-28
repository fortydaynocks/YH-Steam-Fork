extends PlayerExtra

onready var harvest = $"%Harvest"

#	--
func _ready():
	harvest.connect("pressed", self, "emit_signal", ["data_changed"])
	
func show_options():
	.show_options()
	
	harvest.visible = false
	harvest.pressed = false
	
	if is_instance_valid(fighter):
		var closest_bloodflower = fighter.get_closest_flower(fighter, fighter.bloodflower_range)
		if is_instance_valid(closest_bloodflower):
			if closest_bloodflower.can_harvest == true:
				harvest.visible = true
				harvest.pressed = false

func get_extra():
	var extra = {
		"harvest": harvest.pressed, 
	}
	return extra

#func _process(delta):
	#if Global.current_game and self.fighter:
		#var spos = Global.current_game.get_screen_position(1)
		#print(spos, self.fighter.get_pos().x)
		#spos.x += self.fighter.get_pos().x
		#spos.y += 360 / 2
		
		#$"%CheckButton".rect_position = spos
