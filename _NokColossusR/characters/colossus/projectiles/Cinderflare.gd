extends "res://_NokColossusR/characters/colossus/projectiles/CSR-Projectile.gd"

func disable():
	$"%flame".emitting = false
	.disable()

func on_got_blocked():
	.on_got_blocked()
	
	self.get_owner().increment_flamestain(0.5)
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == self.get_owner().opponent:
		self.get_owner().increment_flamestain(0.5)
