extends ObjectState

var quake_lifetime = 60
var chase_multiplier = 0.05

func _exit():
	._exit()
	
	$"%Info".visible = false
	$"%Info".bbcode_text = ""

func _tick():
	._tick()
	
	if current_tick >= quake_lifetime:
		host.disable()
		return
	
func _process(delta):
	$"%Info".visible = host.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	$"%Info".bbcode_text += "Quake\nLifetime: " + str(quake_lifetime - current_tick)
