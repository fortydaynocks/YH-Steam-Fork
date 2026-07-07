extends Fighter

var charname = "Sickness"


#	========================================================================== |
func _tick():
	._tick()
	
	

func _process(d):
	._process(d)
	
	#	--	TENTACLES
	$"%Tentas".visible = true
	$"%Tentas".animation = "tentas"
	$"%Tentas".playing = self.hitlag_ticks <= 0
	$"%Tentas".speed_scale = 1
	
	$"%Tentas".position.y = -self.get_pos().y
	if self.opponent.combo_count >= 1: $"%Tentas".speed_scale = 4
