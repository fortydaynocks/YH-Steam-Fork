extends BaseProjectile

var food = null

func disable():
	self.creator.sustainers.erase(self.obj_name)
	
	.disable()
