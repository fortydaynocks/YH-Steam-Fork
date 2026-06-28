extends "res://_NokPsychoR/characters/psycho/projectiles/PsychoProjectile.gd"

func disable():
	$"%blood".emitting = false
	
	.disable()
