extends ObjectState

func _enter():
	._enter()
	
	match host.randi_range(0, 1):
		0:
			host.sprite.scale.x = -1
		1:
			host.sprite.scale.x = 1
	
	var pos = host.get_pos()		
	var cpos = host.creator.get_pos()
	
	host.set_facing(-1 if cpos.x < pos.x else 1)
