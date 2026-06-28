extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

onready var hbox_test1 = $"Hitbox-Kick"
onready var hbox_test2 = $"Hitbox-Punches"
onready var hbox_test3 = $"Hitbox-QuickSlashes"
onready var hbox_test4 = $"Hitbox-Stomp"
onready var hbox_test5 = $"Hitbox-Slam"
onready var hbox_test6 = $"Hitbox-Slam2"

func _enter():
	._enter()
	
	host.start_invulnerability()

func _exit():
	._exit()
	
	host.release_opponent()
	host.release_camera_focus()
	if !host.is_ghost: Global.current_game.camera_zoom = 1.0

#	--
func _frame_0():
	host.opponent.change_state("Grabbed")
	
	self.offset_x = 300
	self.offset_y = -18
	
	self.switch_animation("rampage", 11)	#	--	ENDING THE INITIAL PUNCH
	
func _frame_1():
	host.opponent.grab_camera_focus()
	if !host.is_ghost: host.create_tween().tween_property(Global.current_game, "camera_zoom", 0.75, 0.5)
	
func _frame_4():
	host.opponent.play_sound("GroundBounce")
	host.opponent.rumble(1, 20)
	
	host.opponent.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(1, 0))
	host.opponent.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(-1, 0))
	
func _frame_11():
	self.switch_animation("crucifix")	#	--	DASH STARTUP
	host.play_sound("chrejection_cloth")
	host.play_sound("comeheres_teleport")
	
func _frame_17():
	self.switch_animation("comehere_yourend", 2)	#	--	DASH
	host.play_sound("introswing")
	
func _frame_23():
	self.switch_animation("devilkick", 5)	#	--	FOLLOWUP KICK
	if !host.is_ghost: host.create_tween().tween_property(Global.current_game, "camera_zoom", 1.0, 0.25)
	$"%Stuff".do_text($"%Stuff".choose_text("_Custom", ["Get up."]))
	
	host.apply_force_relative("8", "0")
	host.release_opponent()
	host.release_camera_focus()
func _frame_24():
	if is_instance_valid(hbox_test1):  hbox_test1.reset_hit_objects(); hbox_test1.activate()
	
#	--	BARRAGE SERIES
func _frame_39():
	self.switch_animation("crosspunch", 3)
func _frame_40():
	if is_instance_valid(hbox_test2): hbox_test2.reset_hit_objects(); hbox_test2.activate()
	
func _frame_45():
	self.switch_animation("savageswipe", 2)
func _frame_46():
	if is_instance_valid(hbox_test2): hbox_test2.reset_hit_objects(); hbox_test2.activate()
	
func _frame_51():
	self.switch_animation("twincarving", 6)
func _frame_52():
	if is_instance_valid(hbox_test2): hbox_test2.reset_hit_objects(); hbox_test2.activate()

#	--	FAST BODY CARVINGS
func _frame_57():
	self.switch_animation("bodycarving", 4)
func _frame_58():
	if is_instance_valid(hbox_test3): hbox_test3.reset_hit_objects(); hbox_test3.activate()

func _frame_61():
	self.switch_animation("bodycarving", 7)
func _frame_62():
	if is_instance_valid(hbox_test3): hbox_test3.reset_hit_objects(); hbox_test3.activate()	

func _frame_65():
	self.switch_animation("bodycarving", 4)
func _frame_66():
	if is_instance_valid(hbox_test3): hbox_test3.reset_hit_objects(); hbox_test3.activate()
	
func _frame_69():
	self.switch_animation("bodycarving", 7)	
func _frame_70():
	if is_instance_valid(hbox_test3): hbox_test3.reset_hit_objects(); hbox_test3.activate()

#	--	STOMP SERIES
func _frame_73():
	self.switch_animation("endbreak", 4)
func _frame_74():
	if is_instance_valid(hbox_test4): hbox_test4.reset_hit_objects(); hbox_test4.activate()
	
func _frame_79():
	self.switch_animation("crimsonfield", 4)
func _frame_86():
	if is_instance_valid(hbox_test5): hbox_test5.reset_hit_objects(); hbox_test5.activate()
	
func _frame_93():
	self.switch_animation("crimsonfield", 3)
func _frame_100():
	if is_instance_valid(hbox_test6): hbox_test6.reset_hit_objects(); hbox_test6.activate()

#	--
func _tick():
	._tick()
	
	if current_tick >= 4 and current_tick <= 23:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "Getup"
		
	if current_tick in [20, 21, 22, 23]:
		host.move_directly_relative("75", "0")
		self.offset_x -= 65
		
	if current_tick % 2 == 0:
		if current_tick >= 0 and current_tick <= 17:
			host.global_hitlag(1)
			
		if current_tick >= 73:
			host.global_hitlag(1)
