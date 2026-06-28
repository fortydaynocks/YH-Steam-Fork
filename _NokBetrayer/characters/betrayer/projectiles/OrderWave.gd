extends "res://_NokBetrayer/characters/betrayer/projectiles/BT-Projectile.gd"

var rift = preload("res://_NokBetrayer/characters/betrayer/projectiles/OrderRift.tscn")
export (bool) var make_rift = true

func disable():
	var pos = self.get_pos()
	var obj = self.get_owner().spawn_object(rift, pos.x, pos.y - 18, true, null, false)
	obj.set_grounded(false)
		
	self.play_sound("Rift")
	
	.disable()
