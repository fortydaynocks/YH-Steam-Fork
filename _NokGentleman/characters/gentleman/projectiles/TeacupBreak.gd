extends ObjectState

var burn_ticks = 0
var burn_damage = 2

func _enter():
	burn_ticks = 0
	host.sprite.visible = false

func _tick():
	._tick()
	
	if burn_ticks > 0:
		if current_tick % 4 == 0:
			host.get_owner().opponent.take_damage(burn_damage)
			burn_ticks -= 1
		
	else:
		if current_tick >= 4 :
			host.disable()

	


func detect(obj):
	.detect(obj)
	
	burn_ticks = 15
