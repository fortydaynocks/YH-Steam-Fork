extends BaseProjectile

var wretchedeye = true
var target = null

var follow_target = null
var follow_offset = Vector2(0, 0)

func disable():
	self.creator.eyes.erase(self.obj_name)
	
	.disable()
