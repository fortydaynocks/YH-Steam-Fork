extends "res://_NokColossusR/characters/colossus/projectiles/CSR-Projectile.gd"

func on_got_blocked():
	.on_got_blocked()

	if self.get_owner().flamestain.Burning == true and self.get_owner().opponent.blocked_hitbox_plus_frames >= 2:
		self.opponent.blocked_hitbox_plus_frames += 1

func disable():
	.disable()
	
	$"%debris".emitting = false
	$"%debris2".emitting = false
	$"%wind".emitting = false
	$"%wind2".emitting = false
	
	$"%Info".visible = false
	$"%Info".bbcode_text = ""
