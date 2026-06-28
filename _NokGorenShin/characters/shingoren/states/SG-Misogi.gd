extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var extra_height = 75
var dist = 60
var initial_dist = 60
var fall = 25

onready var hbox = $HitboxMisogi

func _frame_6():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var dir = (float(data.x) / 100) * dist
	
	host.reset_momentum()
	host.set_pos(str(pos.x), str(opos.y - extra_height))
	host.move_directly_relative(str(initial_dist + dir), "0")
	
	host.afterimage(Color("#ff8933"), 0.25)
	
func _frame_7():
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit1k.tscn"), Vector2(0, -18))
	
func _frame_18():
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Pushblock.tscn"), Vector2(0, 0))
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_AxeStomp.tscn"), Vector2(0, 0))
	
	if is_instance_valid(hbox):
		hbox.deactivate()
	
func _tick():
	._tick()
	
	if current_tick < 6:
		host.apply_force_relative("-3", "0")

	if current_tick >= 8 and current_tick < 18:
		host.move_directly_relative("0", str(fall))
		
		if host.is_grounded():
			current_tick = 17
			
		else:
			if current_tick == 17:
				current_tick = 15
				
		host.afterimage(Color("#ff8933"), 0.1)
