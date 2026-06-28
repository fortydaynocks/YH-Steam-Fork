extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func _frame_2():
	if data == true:
		host.apply_force_relative("0", "8")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		host.apply_torture(obj)
		host.afterimage(Color.red, 1)
		
		host.stress += 0.12
