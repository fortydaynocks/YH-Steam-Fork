extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var offset = Vector2(-40, 0)
var interval = 0.4
var walk_speed = 2

func _frame_1():
	host.play_sound("GrandFinale1")
	host.play_sound("GrandFinaleMain")
	
	host.spawn_particle_effect(particle_scene, Vector2(host.opponent.get_pos().x, host.opponent.get_pos().y))
	
func _frame_24():
	host.play_sound("GrandFinale2")

func _frame_28():
	host.play_sound("GrandFinale2")
	host.play_sound("GrandFinale3")
	host.play_sound("GrandFinale4")

func _tick():
	._tick()
	
	var pos = Vector2(host.get_pos().x, host.get_pos().y)
		
	if current_tick <= 24:
		host.set_vel(str(walk_speed * host.get_facing_int()), str(0))
	
	if current_tick < 28:
		host.global_hitlag(1)
	
	host.afterimage(host.colors_table.MainColor, 0.05)
