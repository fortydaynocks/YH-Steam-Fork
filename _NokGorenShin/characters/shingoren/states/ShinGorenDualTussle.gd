extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var hit_opponent = false
var offset_x = 24
var offset_y = -6
var drag_strength = 2.5

func _enter():
	._enter()
	hit_opponent = false

func _tick():
	._tick()
	
	if hit_opponent == true:
		if current_tick < 12:
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if current_tick < 12:
		if obj == host.opponent:
			hit_opponent = true
