extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var dbox = $DetectBox

var dbox_pos = Vector2(50, -18)
var force = 12
var dist = 175

var target = null

func _frame_0():
	target = null
	
	if is_instance_valid(dbox):
		var dir = xy_to_dir(data.x * host.get_facing_int(), data.y, str(dist))
		dbox.x = dbox_pos.x + int(dir.x)
		dbox.y = dbox_pos.y + int(dir.y)

func _frame_2():
	if !target:
		host.change_state("Wait")
		
func _frame_6():
	if target:
		var obj = host.obj_from_name(target)
		if obj:
			var objpos = obj.get_pos()
			host.set_pos(objpos.x, objpos.y)
			
			host.spawn_particle_effect_relative(
				preload("res://_NokVenerator/venerator/effects/VN-Hit1.tscn"),
				Vector2(0, -18))
			
			obj.disable()

func _frame_7():
	host.update_facing()
	
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Hit1.tscn"),
		Vector2(0, -18))
		
func _frame_12():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	host.apply_force(str(vec.x * force), str(vec.y * force))
	host.afterimage(Color("#ff8933"), 0.1)

func _tick():
	._tick()
	
	if is_instance_valid(dbox) and dbox.active:
		for star in host.objs_map.values():
			if is_instance_valid(star) and !star.disabled and star.get_owner() == host and star.get("tag"):
				if "Protostar" in star.get("tag") and star.collision_box.overlaps(dbox):
					target = star.obj_name
					
					break
