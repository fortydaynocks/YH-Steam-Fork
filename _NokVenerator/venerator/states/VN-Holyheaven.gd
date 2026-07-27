extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")
onready var holyheaven = preload("res://_NokVenerator/venerator/projectiles/Holyheaven.tscn")
var dist = 100
var offset = 50
var force = Vector2(6, 0)

var spawn_count = 3

var speed = 1

func _frame_6():
	pass
	#var dir = xy_to_dir(data.x * host.get_facing_int(), data.y, str(dist))
	
	#for i in range(0, spawn_count):
		#var factor = deg2rad((360 / spawn_count) * i)
		#var force_dir = force.rotated(factor)
		
		#var proj = host.spawn_object(star, int(dir.x) + offset, int(dir.y) - 18, true, null, true)
		#proj.set_grounded(false)
		#proj.apply_force(str(force_dir.x), str(force_dir.y))
	#proj.apply_force(str(force_dir.x), str(force_dir.y))

func _tick():
	._tick()

	if current_tick < 11:
		var dir = xy_to_dir(data.x, data.y, str(speed))
		host.apply_force(dir.x, dir.y)
		
		host.global_hitlag(1)

func _frame_11():
	host.reset_momentum()
	host.apply_force_relative("-6", "-3")
	host.screen_bump(Vector2(0, 0), 2, 0.1)
	
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Flashbeam.tscn"),
		Vector2(16, -30),
		Vector2(host.get_facing_int(), 0)
	)
	
	var proj = host.spawn_object(holyheaven, 150, -25, true, null, true)
	proj.set_grounded(false)
	proj.set_facing(host.get_facing_int())
