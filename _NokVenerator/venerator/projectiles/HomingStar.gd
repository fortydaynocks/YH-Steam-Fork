extends "res://_NokVenerator/venerator/projectiles/VN-Proj.gd"

func hit_by(hitbox):
	.hit_by(hitbox)
	
	if self.current_state().has_method("when_hit"):
		self.current_state().when_hit()
		
	self.current_state().terminate_hitboxes()
	self.can_be_hit_by_melee = false
	self.projectile_immune = true
	
