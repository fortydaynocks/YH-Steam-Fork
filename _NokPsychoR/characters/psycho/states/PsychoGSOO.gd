extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func is_usable():
	return .is_usable() and host.insanity == true

func _enter():
	._enter()
	
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("AISound1")
		
		var opp_name = Network.pid_to_username(host.opponent.id)
		if not opp_name: opp_name = host.opponent.get("charname") 
		if not opp_name: opp_name = host.opponent.obj_name
		
		$"%Stuff".do_text(opp_name + "...")

func _frame_0():
	if $"%Stuff".skin == "Aimorrago":
		pass
	
	else:
		host.play_sound("GSOO")
	
func _tick():
	._tick()
	
	if current_tick < 11:
		host.global_hitlag(3)
		
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	host.insanity = false
