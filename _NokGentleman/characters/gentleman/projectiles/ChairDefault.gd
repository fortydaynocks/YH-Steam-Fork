extends ObjectState

var lifetime = 300
var factor = 2
var last_grounded = false
var imgoingfast = 9

func _enter():
	._enter()
	
	last_grounded = false
	
func _tick():
	._tick()
	
	if current_tick >= lifetime:
		host.disable()
		return
	
	if host.is_grounded() == false:
		var move_speed = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.sprite.rotation_degrees += move_speed.length() * factor
		
		if move_speed.length() >= imgoingfast:
			if current_tick % 4 == 0:
				host.spawn_particle_effect_relative(host.get_owner().vfx_table.Dash, Vector2(0, -8), move_speed.normalized())
			
			if current_tick % 8 == 1:
				host.play_sound("Spin")
			
		
	else:
		host.sprite.rotation_degrees = 0
		
		if last_grounded == false:
			host.play_sound("Land")
			host.spawn_particle_effect_relative(host.get_owner().vfx_table.Landing, Vector2(0, 8))
			

	last_grounded = host.is_grounded()
