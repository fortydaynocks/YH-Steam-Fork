extends ActionUIData

onready var length = $"%Limit/Direction"

func _process(delta):
	if fighter:
		if length.value > fighter.wounds * 2:
			$"%Limit".modulate = Color(0.25, 0.25, 0.25, 1)
			$"%Limit/Label".text = "No Wounds"
			
		else:
			$"%Limit".modulate = Color(1, 1, 1, 1)
			$"%Limit/Label".text = $"%Limit".name
