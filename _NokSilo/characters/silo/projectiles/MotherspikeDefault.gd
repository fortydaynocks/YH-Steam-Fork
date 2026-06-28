extends DefaultFireball


func _tick():
	._tick()
	
	if float(host.get_pos().x) <= - host.stage_width or float(host.get_pos().x) >= host.stage_width:
		host.disable()

func detect(obj):
	.detect(obj)
	
	if obj == host.creator.opponent:
		host.creator.grabbyhands += 1
