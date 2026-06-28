extends "res://_NokBetrayer/characters/betrayer/projectiles/BT-Projectile.gd"

var judge_eye = true
var eye_type = ""
var inconsolable = false
var travel_target = Vector2(0, 0)
		
#	--
func buffer_knight():
	if self.get_owner().knight.NextKnightBuffer: return
	
	self.get_owner().knight.NextKnightBuffer = [eye_type, self.obj_name]
	self.tag = "WaitingEye"
	self.change_state("WaitingEye")
	
func afterimage(color:Color = Color.white, lifetime = 0.2):
	var speed_image_effect = preload("res://fx/SpeedImageEffect.tscn")
	var texture = sprite.frames.get_frame(sprite.animation, sprite.frame)
	var effect = _spawn_particle_effect(speed_image_effect, get_pos_visual() + sprite.offset)
	effect.set_texture(texture)
	effect.lifetime = lifetime
	effect.set_color(color)
	effect.sprite.flip_h = get_facing_int() == - 1

#	--
func hit_by(hitbox):
	self.disable()
	
func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var obj = particle_effect.instance()
	add_child(obj)
	
	self.creator.make_particle_style_color(obj)
				
	#	--
	obj.tick()
	var facing = - 1 if dir.x < 0 else 1
	obj.position = pos
	if facing < 0:
		obj.rotation = (dir * Vector2( - 1, - 1)).angle()
	else :
		obj.rotation = dir.angle()
	obj.scale.x = facing

	remove_child(obj)
	emit_signal("particle_effect_spawned", obj)
	return obj

#	--
func _process(delta):
	._process(delta)
	
	if self.is_ghost == true:
		if self.get_owner().skin == "Munanyou":
			$"%Info".bbcode_text = "[center]Lightning of " + eye_type
			
		else:
			$"%Info".bbcode_text = "[center] Eye of " + eye_type

func tick():
	.tick()
	
	#	--
	if current_tick == 1:
		self.creator.make_particle_style_color(self.sprite)
