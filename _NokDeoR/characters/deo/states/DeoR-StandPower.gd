extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func _frame_2():
	if data.Action:
		host.stand_action(data.Action)
		
		if data.Cost > 0:
			for i in range(0, data.Cost): host.use_super_bar()
			host.super_effect(5)
