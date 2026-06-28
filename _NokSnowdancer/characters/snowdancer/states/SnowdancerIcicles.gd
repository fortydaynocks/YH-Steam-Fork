extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

export (PackedScene) var icicle
var dev = deg2rad(5)
var speed = 12

func spawn_icicle(spawn_angle, vec_dir):
	var obj = host.spawn_object(icicle, cos(spawn_angle) * 20, (sin(spawn_angle) * 20) - 18, false, null, true)
	obj.set_grounded(false)
	obj.set_vel(str(vec_dir.x * speed), str(vec_dir.y * speed))
	obj.sprite.rotation = spawn_angle

func _frame_4():
	var spawn_angle = Vector2(float(data.x), float(data.y)).normalized().angle()
	var spawn_angle2 = Vector2(float(data.x), float(data.y)).normalized().rotated(dev).angle()
	var spawn_angle3 = Vector2(float(data.x), float(data.y)).normalized().rotated(-dev).angle()
	var vec_dir = Vector2(float(data.x), float(data.y)).normalized()
	var vec_dir2 = Vector2(float(data.x), float(data.y)).normalized().rotated(dev)
	var vec_dir3 = Vector2(float(data.x), float(data.y)).normalized().rotated(-dev)
	
	host.spawn_particle_effect_relative(extra_particle, Vector2(vec_dir.x * 20, (vec_dir.y * 20) - 18))
	
	spawn_icicle(spawn_angle, vec_dir)
	spawn_icicle(spawn_angle2, vec_dir2)
	spawn_icicle(spawn_angle3, vec_dir3)
	
