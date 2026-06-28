extends ObjectState

export (bool) var can_transform = true
var can_flame = true
var lifespan = 45
var hits = 2

#	--
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	hits -= 1
	if hits <= 0:
		can_flame = false
		host.disable()
	
func on_got_blocked():
	.on_got_blocked()
	
	host.hitlag_ticks = 6
	host.get_opponent().hitlag_ticks = 6
	
	hits -= 1
	if hits <= 0:
		host.disable()

func on_got_perfect_parried():
	.on_got_perfect_parried()
	
	hits -= 1
	if hits <= 0:
		host.disable()

#	--
func _tick():
	._tick()
	
	var pos = host.get_pos()
	var vel = host.get_vel()
	var opos = host.get_owner().opponent.get_pos()
	
	#	--	LIFETIME
	lifespan -= 1
	if lifespan <= 0:
		host.disable()
		return
	
	#	--	BOUNCE
	if host.is_grounded() == true:
		host.move_directly("0", "-1")
		host.set_vel(vel.x, str(-int(vel.y)))
		
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
		host.play_sound("Bounce")
		
	if abs(pos.x) >= host.stage_width:
		host.set_pos(str(host.stage_width * (pos.x / abs(pos.x))), str(pos.y))
		host.move_directly("-1", "0") if pos.x > 0 else host.move_directly("1", "0")
		host.set_vel(str(-int(vel.x)), vel.y)
		
		host.play_sound("Bounce")
		
	#	--	SPRITE ROTATION
	host.sprite.rotation_degrees = rad2deg(Vector2(vel.x, vel.y).angle())
