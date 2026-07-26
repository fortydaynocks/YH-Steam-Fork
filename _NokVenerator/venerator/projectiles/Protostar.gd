extends "res://_NokVenerator/venerator/projectiles/VN-Proj.gd"

func hit_by(hitbox):
	.hit_by(hitbox)
	
	self.disable()
