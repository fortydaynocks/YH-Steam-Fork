extends "res://_NokSkullmage/characters/skullmage/projectiles/summons/SK-SummonState.gd"

export (String) var move_animation
export (String) var air_animation
export (bool) var use_air_animation = true

var anim_frame = 1
var anim_duration = 4
var anim_frames = 1

func change_animation(anim):
	anim_frames = host.sprite.frames.get_frame_count(anim)
	self.anim_name = anim

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
	
	anim_frame += 1
	change_animation(self.sprite_animation)
	
	#	--	CHASING
	if chase and abs(opos.x - pos.x) > chase_range:
		change_animation(move_animation)
		
	if chase_vertical and abs(opos.y - pos.y) > chase_range:
		change_animation(move_animation)
		
	if not host.is_grounded() and use_air_animation:
		change_animation(air_animation)

func update_sprite_frame():
	.update_sprite_frame()
	
	anim_duration = clamp(anim_duration, 1, INF)
	host.sprite.frame = int(anim_frame / anim_duration) % anim_frames
