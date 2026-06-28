extends BaseProjectile

export (String) var tag

func _ready():
	._ready()
	
	state_variables.append_array(["tag"])
