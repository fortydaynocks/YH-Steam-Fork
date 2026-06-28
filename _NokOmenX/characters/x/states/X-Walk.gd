extends CharacterState

var sprite_frame = 1
var effected_this_frame = false

var duration = 3
var frames = 11

func _frame_1():
	host.reset_momentum()
	host.apply_force_relative("2", "0")
	
func _tick():
	._tick()
	
	sprite_frame += 1
		
	if host.sprite.frame in [3]:
		if effected_this_frame == false:
			effected_this_frame = true
			host.spawn_particle_effect_relative(preload("res://_NokOmenX/characters/x/effects/X-Step.tscn"), Vector2(8, 0))
	
	else:
		effected_this_frame = false
	
func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(sprite_frame / duration) % frames
