extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var beam = preload("res://_NokVenerator/venerator/projectiles/Flashbeam.tscn")
onready var hbox = $Hitbox

var hbox_pos = Vector2(50, -18)
var dist = 125
var offset = 75

var shot = false

func _enter():
	._enter()
	
	shot = false

func _frame_0():
	if is_instance_valid(hbox):
		var dir = xy_to_dir(data.x * host.get_facing_int(), data.y, str(dist))
		hbox.x = hbox_pos.x + int(dir.x)
		hbox.y = hbox_pos.y + int(dir.y)

func _tick():
	._tick()
	
	if is_instance_valid(hbox) and hbox.active and !shot:
		for star in host.objs_map.values():
			if is_instance_valid(star) and !star.disabled and star.get_owner() == host and star.get("tag"):
				if "Protostar" in star.get("tag") and star.collision_box.overlaps(hbox):
					
					#	--
					var proj = host.spawn_object(beam, star.get_pos().x, star.get_pos().y, false, null, false)
					proj.set_grounded(false)
					
					star.disable()		
					shot = true
					break
