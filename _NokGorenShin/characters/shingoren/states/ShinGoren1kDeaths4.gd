extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_0():	
	if not data["Execute"]:
		data["Execute"] = false
	
	if data.get("Blocked") == true:
		host.play_sound("1kDeaths-Blocked2")
		host.play_sound("1kDeaths-Blocked3")
		host.play_sound("1kDeaths_EndShort")
		host.screen_bump(Vector2(0, 0), 8, 0.1)
		
		host.global_hitlag(12)
		
	else:
		host.play_sound("1kDeaths_End")
		host.visible_combo_count = 999
		host.reset_pushback()
		host.opponent.reset_pushback()
	
func _exit():
	._exit()
	host.release_camera_focus()
	
func _frame_1():
	host.grab_camera_focus()
	
	if data["Execute"] == true:
		host.opponent.hp = 0
	
func _frame_32():
	host.release_camera_focus()
	
	self.apply_forces = true
	self.apply_fric = true
	self.apply_grav = true
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and host.opponent.hp <= 0:
		$"%Stuff".unlock_achievement("SG-1K-KILL")
