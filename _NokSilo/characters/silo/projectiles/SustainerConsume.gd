extends ObjectState

onready var bite_hbox = $"%Hitbox"
var scale_divisor = 7.5

func _tick():
	._tick()
	
	if is_instance_valid(data.Target):
		if current_tick == 1:
			if not data.Target is Fighter:
				data.Target.deactivate_hitboxes()
		
		if current_tick == 4:
			var mean_scale = ((data.Scale.x / scale_divisor) + (data.Scale.y / scale_divisor)) / 2
			host.sprite.scale = Vector2(mean_scale, mean_scale)
			
			host.creator.stress -= 0.02
			
			if not data.Target is Fighter:
				host.set_pos(data.Target.get_pos().x, data.Target.get_pos().y)
				
				if data.Method == "Fizzle":
					data.Target.current_state().fizzle()
				elif data.Method == "Disable":
					data.Target.disable()
					
				host.screen_bump(Vector2(0, 0), 1, 0.25)	
				
			else:
				if is_instance_valid(bite_hbox):
					bite_hbox.activate()
					
	if current_tick >= 28:
		host.disable()
