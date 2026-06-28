extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var anim = 1
var anim_duration = 2
var anim_frames = 8

var speed = 40

func _frame_0():
	host.start_projectile_invulnerability()
	host.has_projectile_armor = true

func _exit():
	host.apply_force_relative("6", "0")

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	anim += 1
	host.gain_super_meter(10)
	
	if abs(opos.x - pos.x) > speed / 2:
		host.update_facing()
		host.move_directly_relative(str(speed), "0")
		
	else:
		if current_tick >= 11:
			self.enable_interrupt()
			
	if current_tick % 4 == 0:
		host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(0, -18))

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(anim / anim_duration) % anim_frames
