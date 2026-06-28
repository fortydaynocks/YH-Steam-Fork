extends CharacterState

var sprite_frame = 1
var effected_this_frame = false

var duration = 2
var frames = 7

func _frame_1():
	if self._previous_state_name() != self.state_name:
		host.reset_momentum()
		host.apply_force_relative("6", "0")
	
func _tick():
	._tick()
	
	sprite_frame += 1
	host.update_facing()
	
	if abs(int(host.get_vel().x)) < 8:
		duration = 2
	else:
		duration = 1
	
	if abs(int(host.get_vel().x)) < 20:
		host.apply_force_relative("1", "0")
	
	#	--
	host.afterimage(Color("#ff0000"), 0.05)	
	
	if host.sprite.frame in [5]:
		if effected_this_frame == false:
			effected_this_frame = true
			host.spawn_particle_effect_relative(preload("res://_NokOmenX/characters/x/effects/X-Step.tscn"), Vector2(8, 0))
			host.screen_bump(Vector2(0, 1), 1, 0.1)
	
	else:
		effected_this_frame = false
	
func update_sprite_frame():
	.update_sprite_frame()
	
	host.sprite.frame = int(sprite_frame / duration) % frames
