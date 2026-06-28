extends "res://_NokDurmak/characters/durmak/summons/WalkerState.gd"

export (String) var move_animation
export (String) var air_animation

var anim_frame = 1
var anim_duration = 8
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
		
	if not host.is_grounded():
		change_animation(air_animation)

	#	--	JUMPING
	if host.is_grounded() and abs(opos.y - pos.y) > 75:
		host.apply_force_relative("0", "-5")
		
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2())
		host.play_sound("Jump")

func update_sprite_frame():
	.update_sprite_frame()
	
	anim_duration = clamp(anim_duration, 1, INF)
	host.sprite.frame = int(anim_frame / anim_duration) % anim_frames
