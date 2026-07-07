extends CharacterState

#	--	DRAG SCRIPT

export var _c_drag = 0
export (bool) var drag = false
export (int) var offset_x = 0
export (int) var offset_y = 0
export (int) var start_on = 1
export (int) var end_on = 1
export (float) var drag_strength = 2.5
export (bool) var force_drag = false

export var _c_hellsaint = 0
export (bool) var needs_array = false

var sprite_delay = 0

func is_usable():
	if needs_array:
		return .is_usable() and len(host.get_spike_arrays()) > 0
		
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

func _tick():
	._tick()
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))


#	--
func _process(d):
	var main_scene = host.get_tree().get_current_scene()
	var buttons = main_scene.get_node("%P1ActionButtons") if host.id == 1 else main_scene.get_node("%P2ActionButtons")
	var fl = buttons.get_node("BottomRow/PanelContainer/CategoryContainer/Control/VBoxContainer/CenterContainer/FrameLabel")
	
	var color = "#ff0044"
	if self.super_level_ < 1: color = "#4d0014"
	if self.super_level_ == 2: color = "#990029"
	
	var bbcode = "[color=%s]LEVEL %d[/color]" % [color, self.super_level_]
	if self.super_level_ >= 4: bbcode = "[shake]" + bbcode
	
	fl.bbcode_text = bbcode
