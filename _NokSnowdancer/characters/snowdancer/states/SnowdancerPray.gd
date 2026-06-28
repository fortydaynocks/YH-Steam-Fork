extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

var frame = 1

var duration = 4
var frames = 8

var fast_prayer = false
var very_fast_prayer = false

func is_usable():
	if self.name == "pray1":
		return .is_usable() and host.snowflakes.value == 0
	if self.name == "pray2":
		return .is_usable() and host.snowflakes.value == 1
	if self.name == "pray3":
		return .is_usable() and host.snowflakes.value == 2
	if self.name == "pray4":
		return .is_usable() and host.snowflakes.value == 3
	
	return .is_usable()

func _enter():
	._enter()
	
	if self.name == "pray2":
		host.play_sound("PrayExtra")
		
	if self.name == "pray3":
		host.play_sound("PrayExtra")
		host.play_sound("PrayExtra2")
		
	if self.name == "pray4":
		host.play_sound("PrayExtra")
		host.play_sound("PrayExtra2")
		host.play_sound("PrayExtra3")
		
		if host.elegant_storm <= 0:
			host.elegant_storm = 240
			
			host.grab_camera_focus()
		else:
			host.elegant_storm += 40
			
	#	--
	fast_prayer = false
	very_fast_prayer = false
	
	self.interruptible_on_opponent_turn = false
	
	if data == true:
		fast_prayer = true
		
		if data == true:
			host.use_super_bar()
			
	if host.combo_count > 0:
		very_fast_prayer = true
	

func _exit():
	._exit()
	
	host.release_camera_focus()

func _frame_1():
	host.increment_snowflakes(1)
	host.afterimage(Color(0.8, 0.86, 0.99, 0.2), 0.2)

func _frame_9():
	if very_fast_prayer == true:
		self.enable_interrupt()

func _frame_11():
	if fast_prayer == true:
		self.enable_interrupt()

func _tick():
	if current_tick in [1, 2, 3, 4, 5, 6]:
		host.global_hitlag(1)
		
	frame += 1
	duration = 5 - host.snowflakes.value
	
	if fast_prayer == false and host.combo_count < 1:
		host.gain_super_meter(8)
	
	#	--
	self.interruptible_on_opponent_turn = (fast_prayer == true and current_tick > 5)
	
func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(frame / duration) % frames
