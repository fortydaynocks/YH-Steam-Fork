extends "res://projectile/DirProjectileDefault.gd"

export (PackedScene) var fire
var pos

func _enter():
	pos = host.get_pos()

func _tick():
	._tick()
	
	if pos:
		var newpos = host.get_pos()
	
		if abs(float(newpos.x) - float(pos.x)) >= 50:
			pos = newpos
		
			host.creator.spawn_object(fire, newpos.x, newpos.y, false, null, false)
		
