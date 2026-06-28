extends ObjectState

#	--
func fizzle():
	host.disable()

func _enter():
	._enter()
	
	host.ripe = false
	host.set_facing(host.randi_choice([-1, 1]))

func _frame_26():
	host.ripe = true
