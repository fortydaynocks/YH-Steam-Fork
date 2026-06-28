extends ObjectState

export (int) var _c_summon
export (bool) var action = false
export (int) var timeout = 0
export (bool) var auto_facing = true
export (bool) var disable_after = false

export (bool) var chase = true
export (int) var chase_range = 100
export (float) var chase_speed = 0.5
export (bool) var chase_vertical = false
export (int) var chase_limit = -1

func _enter():
	._enter()
	
func _exit():
	._exit()
	
	if disable_after:
		host.disable()

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
	
	if current_tick <= 0:
		host.timeout = timeout
	
	#	--	FACING
	if auto_facing or current_tick <= 2:
		host.set_facing(1 if opos.x > pos.x else -1)
	
	#	--	CHASING
	if chase_limit == -1 or current_tick <= chase_limit:
		if chase and abs(opos.x - pos.x) > chase_range:
			host.apply_force_relative(str(chase_speed), "0")
			
		if chase_vertical and abs(opos.y - pos.y) > chase_range:
			host.apply_force("0", str(chase_speed if opos.y > pos.y else -chase_speed))
