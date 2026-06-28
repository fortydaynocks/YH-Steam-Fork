extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _exit():
	._exit()
	
	host.release_camera_focus()

func _frame_0():
	host.opponent.change_state("Grabbed")
	host.grab_camera_focus()

func _frame_8():
	host.play_sound("bisection-swing")

func _frame_20():
	host.play_sound("bisection-swing2")

func _frame_24():
	host.release_opponent()
	
func _frame_25():
	host.opponent.change_state("Grabbed")
	
	
func _frame_34():
	host.release_opponent()
	host.release_camera_focus()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and (not "NoCripple" in hitbox.misc_data):
		var opos = host.opponent.get_pos()
		
		host.spawn_particle_effect(preload("res://_NokDurmak/characters/durmak/effects/DM-Bisection.tscn"), Vector2(opos.x, opos.y))

func _tick():
	._tick()
	
	if current_tick <= 22:
		host.global_hitlag(1)
		
	if current_tick > 25 and current_tick <= 32:
		host.global_hitlag(1)

	if current_tick > 35:
		host.global_hitlag(1)

	#	--
	if current_tick < 35:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "HurtGroundedHigh"
	
	if current_tick < 25:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "Getup"
		
