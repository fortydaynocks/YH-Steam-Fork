extends BaseProjectile

export (String) var tag
export (PackedScene) var disable_particle

func _ready():
	._ready()
	
	state_variables.append_array(["tag"])

func disable():
	if disable_particle:
		self.spawn_particle_effect_relative(disable_particle, Vector2(0, 0))
	
	.disable()

#	--
func spawn_object(projectile:PackedScene, pos_x:int, pos_y:int, relative = true, data = null, local = true):
	var obj = .spawn_object(projectile, pos_x, pos_y, relative, data, local)
	
	obj.sprite.material = self.get_owner().sprite.material
	if self.get_owner().applied_style and self.get_owner().applied_style.get("extra_color_1"):
		self.get_owner().get_node("%Stuff").recursive_style_modulation(obj)
		
	return obj

func _spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	var obj = ._spawn_particle_effect(particle_effect, pos, dir)
	
	if self.get_owner().applied_style and self.get_owner().applied_style.get("extra_color_1"):
		self.get_owner().get_node("%Stuff").recursive_style_modulation(obj)
	
	return obj
