extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")
onready var beam = preload("res://_NokVenerator/venerator/projectiles/Flashbeam.tscn")
onready var hbox = $Hitbox

var spawned_stars = []
var shot = false

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		var pos = host.get_pos()
		var fac = host.get_facing_int()
			
		var proj = host.spawn_object(star, pos.x + (100 * fac), pos.y - 30, true, null, false)
		proj.set_grounded(false)
		
		var proj2 = host.spawn_object(star, pos.x + (400 * fac), pos.y - 30, true, null, false)
		proj2.set_grounded(false)
		
		var proj3 = host.spawn_object(star, pos.x + (700 * fac), pos.y - 30, true, null, false)
		proj3.set_grounded(false)
		
		spawned_stars.append(proj.obj_name)
		spawned_stars.append(proj2.obj_name)
		spawned_stars.append(proj3.obj_name)

func on_got_blocked():
	.on_got_blocked()
	
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
		
	var proj = host.spawn_object(star, opos.x, opos.y - 18, true, null, false)
	proj.set_grounded(false)
	proj.set_vel(str(-5 * host.get_facing_int()), "0")
	
	var proj2 = host.spawn_object(star, opos.x, opos.y - 18, true, null, false)
	proj2.set_grounded(false)
	proj2.set_vel(str(5 * host.get_facing_int()), "0")
	
	var proj3 = host.spawn_object(star, opos.x, opos.y - 18, true, null, false)
	proj3.set_grounded(false)
	proj3.set_vel(str(0 * host.get_facing_int()), "-5")
	
	spawned_stars.append(proj.obj_name)
	spawned_stars.append(proj2.obj_name)
	spawned_stars.append(proj3.obj_name)

func _frame_0():
	spawned_stars = []
	shot = false
	
	if data:
		host.apply_force_relative("0", "10")

func _frame_11():
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-FlashbeamX.tscn"),
		Vector2(16, -30),
		Vector2(host.get_facing_int(), 0)
	)
	
func _tick():
	._tick()
	
	if is_instance_valid(hbox) and hbox.active and !shot:
		for star in host.objs_map.values():
			if is_instance_valid(star) and !star.disabled and star.get_owner() == host:
				if star.get("tag") and "Protostar" in star.tag and star.collision_box.overlaps(hbox):
					if !star.obj_name in spawned_stars:
						
						#	--
						var proj = host.spawn_object(beam, star.get_pos().x, star.get_pos().y, false, null, false)
						proj.set_grounded(false)
						
						proj.hitlag_ticks = 10
						
						star.disable()		
						shot = true
						break
