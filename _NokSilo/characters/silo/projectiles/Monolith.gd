extends BaseProjectile

func disable():
	self.creator.monoliths.erase(self.obj_name)
	
	.disable()
