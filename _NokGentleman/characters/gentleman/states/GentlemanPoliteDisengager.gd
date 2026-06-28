extends "res://_NokGentleman/characters/gentleman/states/GentlemanThrowState.gd"

var hit_tick = -1

func _enter():
	._enter()
	
	hit_tick = -1

func _frame_26():
	host.play_sound("WipeSelf")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	hit_tick = current_tick
	
func _tick():
	._tick()
	
	if hit_tick != -1 and current_tick == hit_tick + 1:
		host.grant_random_item(true, false)
