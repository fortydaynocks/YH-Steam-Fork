extends DefaultFireball

onready var star = preload("res://_NokVenerator/venerator/projectiles/Protostar.tscn")
var force = Vector2(6, 0)
var interval = 10
var spawn_count = 3
var blast_time = 40

var hit_opponent = false
var drag_force = 1.25

func _enter():
	._enter()
	
	hit_opponent = false

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.get_opponent():
		hit_opponent = true

func _frame_29():
	var pos = host.get_pos()
	
	for i in range(0, spawn_count):
		var factor = deg2rad(((360 / spawn_count) * i) - 90)
		var force_dir = force.rotated(factor)
		
		var proj = host.get_owner().spawn_object(star, pos.x, pos.y, false, null, false)
		proj.set_grounded(false)
		proj.apply_force(str(force_dir.x), str(force_dir.y))
	
	#	--
	host.play_sound("Blast")
	host.play_sound("Blast2")
	
	host.screen_bump(Vector2(0, 0), 2, 0.1)
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Star3.tscn"),
		Vector2(0, 0)
	)
	
	host.disable()

#	--
func _tick():
	._tick()
	
	if current_tick % interval == 0 and current_tick < 40:
		host.play_sound("Collapse")
		$"%Collapse".start_emitting()
		
	if hit_opponent:
		var pos = host.get_pos()
		var opos = host.get_opponent().get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		
		host.get_opponent().apply_force(str(-vec.x * drag_force), str(-vec.y * drag_force))
		
	
		
