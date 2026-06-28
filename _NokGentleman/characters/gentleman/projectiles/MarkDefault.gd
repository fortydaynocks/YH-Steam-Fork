extends ObjectState

var target
var home_speed = 1
var home_start = 14

#	TARGET PRIORITIES
#	1 - OPPONENT
#	2 - TEACUPS

func _tick():
	._tick()
	
	if current_tick >= home_start:
		for obj in host.objs_map.values():
			if is_instance_valid(obj) and obj.disabled != true and (not obj in [host, host.get_owner()]):
				if not obj.get("tag") in ["Mark", "Agent"]:
					if host.collision_box.overlaps(obj.hurtbox):
						var pos = Vector2(host.get_pos().x, host.get_pos().y)
						var opos = Vector2(obj.get_pos().x, obj.get_pos().y)
						if obj is Fighter: opos.y -= 18
						
						var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
						
						host.apply_force(str(vec.x * home_speed), str(vec.y * home_speed))
						
						break
				
				
