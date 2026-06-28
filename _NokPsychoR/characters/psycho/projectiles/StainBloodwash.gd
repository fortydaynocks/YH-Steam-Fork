extends ObjectState

onready var redknife = preload("res://_NokPsychoR/characters/psycho/projectiles/RedKnife.tscn")
var particle = preload("res://_NokPsychoR/characters/psycho/effects/PsychoBloodwashSlash.tscn")
var particle2 = preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit2.tscn")
var move_speed = 2

var hits = 0
var max_hits = 4
var lifetime = 45

func _frame_0():
	host.play_sound("Bloodwash")
	host.play_sound("Bloodwash2")
	host.screen_bump(Vector2(0, 0), 8, 0.25)
	
	hits = 0

func _tick():
	._tick()
	
	if host.get_owner().opponent.combo_count >= 1:
		host.disable()
	
	if current_tick % 4 == 0:
		host.spawn_particle_effect_relative(particle, Vector2(0, 0))
	
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()
	var dist = Vector2(opos.x - pos.x, (opos.y - pos.y) - 18).normalized()
	
	host.move_directly(str(dist.x * move_speed), str(dist.y * move_speed))

	if current_tick >= lifetime or hits >= max_hits:
		disable()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.get_owner().opponent:
		hits += 1

func on_got_blocked():
	.on_got_blocked()
	
	hits += 1

func disable():
	
	host.play_sound("Bloodstream")
	host.spawn_particle_effect_relative(particle2, Vector2(0, 0))
	host.screen_bump(Vector2(0, 0), 8, 0.25)
	
	var pos = host.get_pos()
	var k1 = host.creator.spawn_object(redknife, pos.x, pos.y, false, null, false)
	var k2 = host.creator.spawn_object(redknife, pos.x, pos.y, false, null, false)
	var k3 = host.creator.spawn_object(redknife, pos.x, pos.y, false, null, false)
	
	k1.set_grounded(false)
	k2.set_grounded(false)
	k3.set_grounded(false)
	
	k1.apply_force("-12", "4")
	k2.apply_force("12", "4")
	k3.apply_force("0", "-8")
	
	host.disable()
