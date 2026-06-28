extends BaseProjectile

var victim = null

func disable():
	self.creator.torturemarks.erase(self.obj_name)
	
	.disable()
