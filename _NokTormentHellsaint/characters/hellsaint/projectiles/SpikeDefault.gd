extends DefaultFireball

func _enter():
	._enter()
	
	anim_name = "proj-spike" + str(host.randi_range(1, 4))

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if host.creator.terminus == true:
		host.creator.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/EyeSpike.tscn"), 0, 0, false, {"sprrot": host.randi_range(0, 360)}, true)
