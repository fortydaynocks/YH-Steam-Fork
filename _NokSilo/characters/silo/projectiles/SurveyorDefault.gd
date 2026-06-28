extends DefaultFireball

func _tick():
	._tick()
	
	if current_tick in [11, 12, 13, 14]:
		for flower in host.creator.bloodflowers:
			var flower_obj = host.creator.objs_map[flower]
			if is_instance_valid(flower_obj):
				if host.collision_box.overlaps(flower_obj.hurtbox) and flower_obj.get("ripe") != false:
					
					flower_obj.graduate()
					
					host.screen_bump(Vector2(0, 0), 6, 0.25)
					host.creator.spawn_particle_effect(particle_scene, Vector2(host.get_pos().x, host.get_pos().y))
					return
