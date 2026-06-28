extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var interrupt_at = 0
var tick_divisor = 20.0

var seltaunt = {
	"textScrollSpeed": 0.015,
	"tweenText": null,
	"tweenModulate": null,
} 

#	IF YOU SEE THIS, PLEASE DONT JUST COPY THIS TAUNT.
#	IT'S MEANT TO BE A SPECIAL THING. 
#	THANKS

#	- nok

func seltaunt_start():
	$"%SelectiveTaunt".bbcode_text = ""
	
	if is_instance_valid($"%SelectiveTaunt") and data.Text:
		if seltaunt.tweenText: seltaunt.tweenText.kill()
		if seltaunt.tweenModulate: seltaunt.tweenModulate.kill()
		$"%SelectiveTaunt".modulate = Color(1, 1, 1, 1)
		$"%SelectiveTaunt".percent_visible = 0.0
		
		#	--
		$"%SelectiveTaunt".bbcode_text = "[center]" + data.Text
		seltaunt.tweenText = create_tween()
		seltaunt.tweenText.tween_property($"%SelectiveTaunt", "percent_visible", 1.0, seltaunt.textScrollSpeed * (len($"%SelectiveTaunt".bbcode_text) - 8))
		
	if data.Skip == false:
		host.play_sound("Seltaunt1")

func seltaunt_tick():
	self.anim_name = "seltaunt" + str(data.Emote)
	
	if len(data.Text) >= 1:
		self.ticks_per_frame = clamp(round(len(data.Text)) / tick_divisor, 1, INF)
	else:
		self.ticks_per_frame = 2
	
	if current_tick < 8:
		host.global_hitlag(1)
		
	if data.Skip == true:
		host.sprite.frame = 999

func seltaunt_end():
	if is_instance_valid($"%SelectiveTaunt"):
		seltaunt.tweenModulate = create_tween()
		seltaunt.tweenModulate.tween_property($"%SelectiveTaunt", "modulate", Color(1, 1, 1, 0), 0.5)

func _enter():
	._enter()
	
	interrupt_at = 0
	seltaunt_start()
	

func _exit():
	._exit()
	seltaunt_end()

func _tick():
	._tick()
	
	host.gain_super_meter(2)
	
	if host.state_interruptable == true:
		interrupt_at = 0
		
	if host.was_my_turn == true:
		interrupt_at = 0
		
	if interrupt_at == 14:
		enable_interrupt()
		interrupt_at = 0
		
	if interrupt_at < 14:
		interrupt_at += 1
		
	#	--	SELTAUNT
	
	seltaunt_tick()
	
	
func can_interrupt():
	.can_interrupt()
	
	
