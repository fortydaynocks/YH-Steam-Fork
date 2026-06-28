extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var anim = 1
var anim_duration = 4
var anim_frames = 8

func _frame_1():
	host.apply_force_relative("4", "0")

func _tick():
	._tick()
	
	anim += 1

func update_sprite_frame():
	.update_sprite_frame()
	host.sprite.frame = int(anim / anim_duration) % anim_frames
