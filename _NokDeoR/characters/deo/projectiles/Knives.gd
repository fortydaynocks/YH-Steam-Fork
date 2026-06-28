extends "res://_NokDeoR/characters/deo/projectiles/DeoR-Projectile.gd"

func timestopped():
	pass
	
func on_got_blocked():
	self.disable()
	
func hit_by(hitbox):
	.hit_by(hitbox)
	
	#if hitbox and objs_map[hitbox.host].is_in_group("Fighter"):
		#self.get_opponent().projectile_free_cancel()
	
	self.disable()
	
