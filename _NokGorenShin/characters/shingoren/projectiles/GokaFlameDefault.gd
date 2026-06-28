extends ObjectState

var lifespan = 75
var chasing = false
var force = 0.6

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	host.disable()
	
func on_got_blocked():
	.on_got_blocked()
	
	host.disable()

func on_got_perfect_parried():
	.on_got_perfect_parried()
	
	host.disable()

func detect(obj):
	.detect(obj)
	
	if obj == host.get_opponent():
		var opos = host.get_opponent().get_pos()
		
		chasing = true
		lifespan = 45
		
		host.play_sound("Chase")
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Misc2.tscn"), Vector2())
		host.spawn_particle_effect(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Misc2.tscn"), Vector2(opos.x, opos.y - 18))

func _tick():
	._tick()
	
	var pos = host.get_pos()
	
	#	--	LIFETIME
	lifespan -= 1
	if lifespan <= 0:
		host.disable()
		return
	
	#	--	CHASE
	if chasing:
		var opos = host.get_opponent().get_pos()
		var vec = Vector2(opos.x - pos.x, (opos.y - 18) - pos.y).normalized()
		host.apply_force(str(vec.x * force), str(vec.y * force))
