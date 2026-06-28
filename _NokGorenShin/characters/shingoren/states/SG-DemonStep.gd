extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var step_mul = 0.5
var launch_speed = 2

func _enter():
	._enter()
	
	host.load_last_input_into_buffer()
	
	if host.buffered_input.extra.get("DemonStep"):
		host.buffered_input.extra.DemonStep = false

func _frame_4():
	host.play_sound("AshuraSenku")
	
	if host.is_grounded():
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke1.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))

func _frame_7():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	host.apply_force(str(vec.x * launch_speed), str(vec.y * launch_speed))
	host.use_buffer()
			
func _tick():
	._tick()
	
	if data and current_tick in [4, 5, 6, 7]:
		var pos = Vector2(host.get_pos().x, host.get_pos().y)
		var lpos = lerp(pos, data, step_mul)
		
		host.set_pos(str(lpos.x), str(lpos.y))
		
		host.global_hitlag(1)
		host.opponent.hitlag_ticks = 1
	
	host._create_speed_after_image(Color("ff0044"), 0.15)
		
		
