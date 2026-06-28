extends BaseProjectile

var fuckingtraitor = true

func _create_speed_after_image(color:Color = Color.white, lifetime = 0.2):
	var speed_image_effect = preload("res://fx/SpeedImageEffect.tscn")
	var texture = sprite.frames.get_frame(sprite.animation, sprite.frame)
	var effect = _spawn_particle_effect(speed_image_effect, get_pos_visual() + sprite.offset)
	effect.set_texture(texture)
	effect.lifetime = lifetime
	effect.set_color(color)
	effect.sprite.flip_h = get_facing_int() == - 1

func on_got_blocked():
	.on_got_blocked()
	
	disable()
	
func on_got_parried():
	.on_got_parried()
	
	disable()
	
func disable():
	
	fuckingtraitor = false
	self.spawn_particle_effect(self.creator.vfx_table.Slash, Vector2(float(self.get_pos().x), float(self.get_pos().y)))
	.disable()
