extends ObjectState

export (bool) var action = false
export (bool) var choosable = false
export (bool) var instant = false
export (String) var action_name = ""
export (int) var end_action = -1
export (bool) var face_opponent = true
export (bool) var pushable = true
var actionable = true

func _enter():
	._enter()
	
	if action == true:
		actionable = false

func _tick():
	._tick()
	
	if face_opponent == true and current_tick == 1:
		host.set_facing(1 if host.get_owner().opponent.get_pos().x > host.get_pos().x else -1)

	if actionable == false and end_action >= 0 and current_tick >= end_action:
		actionable = true
