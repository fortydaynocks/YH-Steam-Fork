extends BaseProjectile

func disable():
	.disable()
	
	creator.currentplume = null
