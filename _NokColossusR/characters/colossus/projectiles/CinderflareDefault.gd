extends DefaultFireball

var bolt_force = 8

func _on_hit_something(obj, _hitbox):
	._on_hit_something(obj, _hitbox)
	
	host.disable()

func on_got_blocked():
	.on_got_blocked()
	
	host.disable()
	
func on_got_parried():
	.on_got_parried()
	
	host.disable()

func _tick():
	._tick()

	#	--	RICOCHET
	
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()

	if host.get_owner().hitlag_ticks < 1:
		for hbox in host.get_owner().get_active_hitboxes():
			if is_instance_valid(hbox) and hbox.overlaps(host.hurtbox):
				host.get_owner().feinting = true
				
				host.global_hitlag(12)
				host.screen_bump(Vector2(0, 0), 16, 0.1)
				host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-HitFlame.tscn"), Vector2(0, 0))
				
				host.play_sound("Struck")
				host.play_sound("Struck2")
				
				var vec = Vector2(opos.x - pos.x, (opos.y - 18) - pos.y).normalized()
				var obj = host.get_owner().spawn_object(preload("res://_NokColossusR/characters/colossus/projectiles/Firebolt.tscn"), pos.x, pos.y, false, null, false)
				
				obj.set_grounded(false)
				obj.apply_force(str(vec.x * bolt_force), str(vec.y * bolt_force))
				
				host.disable()
