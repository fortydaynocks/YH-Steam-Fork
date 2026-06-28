extends "res://_NokGorenShin/characters/shingoren/projectiles/SG-Projectile.gd"

#	--
func disable():
	if self.current_state().get("can_flame"):
		var pos = self.get_pos()
		var vel = self.get_vel()
		
		var flame = self.get_owner().spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/GokaFlame.tscn"), pos.x, pos.y, false, null, false)
		flame.set_grounded(false)
		flame.set_vel(vel.x, vel.y)
	
	.disable()
