extends "res://_NokGorenShin/characters/shingoren/projectiles/SG-Projectile.gd"

#	--
func disable():
	if self.current_state().get("can_flame"):
		var pos = self.get_pos()
		var vec = Vector2(0, -10)
		
		for i in range (0, 3):
			var flame = self.get_owner().spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/GokaFlameOrange.tscn"), pos.x, pos.y, false, null, false)
			flame.set_grounded(false)
			flame.set_vel(str(vec.x), str(vec.y))
			vec = vec.rotated(deg2rad(120))
	
	.disable()
