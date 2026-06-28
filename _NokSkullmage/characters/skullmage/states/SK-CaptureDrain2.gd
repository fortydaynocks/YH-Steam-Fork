extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	#if obj == host.opponent and "GivePoint" in hitbox.misc_data:
		#host.points.Value += 1
