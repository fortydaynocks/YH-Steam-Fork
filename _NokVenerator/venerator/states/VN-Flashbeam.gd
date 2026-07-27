extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		var opos = host.opponent.get_pos()
		var ovel = host.opponent.get_vel()
		
		var proj = host.spawn_object(star, opos.x, opos.y - 18, true, null, false)
		proj.set_grounded(false)
		proj.set_vel(str(15 * host.get_facing_int()), "0")

func on_got_blocked():
	.on_got_blocked()
	
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
		
	var proj = host.spawn_object(star, opos.x, opos.y - 18, true, null, false)
	proj.set_grounded(false)
	proj.set_vel(str(5 * host.get_facing_int()), "0")
	

func _frame_0():
	if data:
		host.apply_force_relative("0", "6")

func _frame_8():
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Flashbeam.tscn"),
		Vector2(16, -30),
		Vector2(host.get_facing_int(), 0)
	)
