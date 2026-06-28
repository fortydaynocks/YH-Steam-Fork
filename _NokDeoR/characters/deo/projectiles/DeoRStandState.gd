extends ObjectState

export (bool) var _c_Stand
export (bool) var action = true
export (StreamTexture) var action_icon = preload("res://ui/ActionSelector/StateIcons/no_icon.png")
export (bool) var fully_actionable = true
export (int) var iasa_on_hit = -1
export (bool) var self_cancellable = true
export (bool) var flip_on_entry = false

export (int) var action_cost = 0
export (String, MULTILINE) var action_stances = "All"

var actionable = true
var active_iasa_on_hit = -1

#	--
func face_opponent():
	var pos = Vector2(host.get_pos().x, host.get_pos().y)
	var opos = Vector2(host.creator.opponent.get_pos().x, host.creator.opponent.get_pos().y)
	
	host.set_facing(1 if pos.x < opos.x else -1)



#	--
func _enter():
	._enter()
	
	active_iasa_on_hit = -1
	
	if flip_on_entry == true:
		face_opponent()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	active_iasa_on_hit = iasa_on_hit

func _tick():
	._tick()
	
	var pos = Vector2(host.get_pos().x, host.get_pos().y)
	var cpos = Vector2(host.creator.get_pos().x, host.creator.get_pos().y)
	var opos = Vector2(host.creator.opponent.get_pos().x, host.creator.opponent.get_pos().y)
	
	if fully_actionable:
		actionable = true
	else:
		actionable = false
		
		if iasa_on_hit > -1:
			actionable = host.hit_fighter_last() and (iasa_on_hit > -1 and self.current_tick >= iasa_on_hit)
