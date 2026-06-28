extends "res://characters/states/OffensiveBurst.gd"

func is_usable():
	return .is_usable() and host.current_state().hit_fighter == true

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		if host.terminus != true:
			host.terminus_time = 120
			host.terminus = true
			
			host.play_sound("terminus_ambiencefaint")

			if $"%Stuff".skin == "Camila":
				host.play_sound("CA_Terminus")
		
		else:
			host.terminus_time += 120
