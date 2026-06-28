extends ObjectState

var mul = 0.05
var offset = Vector2(50, -100)

func _enter():
	._enter()

func _exit():
	._exit()
	
	host.sprite.rotation_degrees = 0

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var cpos = host.get_owner().get_pos()
	var opos = host.get_owner().opponent.get_pos()
	
	host.set_facing(host.get_owner().get_facing_int())
	
	#	--	POSITIONING
	var lpos = lerp(Vector2(pos.x, pos.y), Vector2(cpos.x + (offset.x * host.get_facing_int()), cpos.y + offset.y), mul)
	host.set_pos(str(lpos.x), str(lpos.y))

	#	--	ORIENTATION
	var angle = Vector2((opos.x - pos.x) * host.get_facing_int(), opos.y - pos.y).angle()
	host.sprite.rotation_degrees = rad2deg(angle)
