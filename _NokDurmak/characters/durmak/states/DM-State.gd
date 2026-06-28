extends CharacterState

#	--	DRAG SCRIPT

export var _c_drag = 0
export (bool) var drag = false
export (Vector2) var offset = Vector2(0, 0)
export (int) var start_on = 1
export (int) var end_on = 1
export (float) var drag_strength = 2.5
export (bool) var force_drag = false

export var _c_durmak = 0
export (int) var bleed = 0
export (bool) var cripple = false

var sprite_delay = 0

func is_usable():
	return .is_usable()

#	--	MODIFIED SPRITE DISPLAY
func update_sprite_frame():	
	if not host.sprite.frames.has_animation(anim_name):
		return 
	if host.sprite.animation != anim_name:
		host.sprite.animation = anim_name
		host.sprite.frame = 0
		
	#	--
	var sprite_tick = ((current_tick - sprite_delay) / ticks_per_frame)

	if loop_animation and absolute_loop:
		sprite_tick = host.current_tick / ticks_per_frame
	elif loop_animation and not refresh_loop:
		if same_as_last_state:
			sprite_tick = (current_tick + exit_tick) / ticks_per_frame
	
	var frame = (sprite_tick % (sprite_anim_length - animation_loop_start) + animation_loop_start) if (loop_animation and sprite_tick > animation_loop_start) else Utils.int_min(sprite_tick, sprite_anim_length)
	host.sprite.frame = frame

func switch_animation(anim, start = 0):
	if not host.sprite.frames.has_animation(anim):
		return 
	
	self.anim_name = anim
	sprite_delay = (self.current_tick - (start * ticks_per_frame)) + 1

#	--
func _enter():
	._enter()
	
	sprite_delay = 0

func _on_hit_something(obj, hbox):
	._on_hit_something(obj, hbox)
	
	if obj == host.opponent:
		if (not "NoCripple" in hbox.misc_data) and cripple:
			host.cripple()
		
		if (not "NoBleed" in hbox.misc_data) and bleed > 0:
			if host.bleed.cripple:
				host.bleed.turns += bleed
				
			else:
				if bleed > host.bleed.turns:
					host.bleed.turns = bleed

func _tick():
	._tick()
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset.x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - offset.y - opos.y) / drag_strength))
