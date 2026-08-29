extends BaseProjectile

var split = false
var parry_grace = 0

func tick():
	.tick()
	if not disabled:
		if current_tick % 5 == 0:
			play_sound("Rumble")
	set_pos(get_pos().x, 0)

	if hitlag_ticks <= 0:
		parry_grace = min(parry_grace + 1, 5)
		if parry_grace >= 5:
			has_projectile_parry_window = true
		else:
			has_projectile_parry_window = false
		for objs in objs_map.values():
			if is_instance_valid(objs):
				if objs is BaseProjectile:
					if objs.hurtbox.overlaps(collision_box) and not objs.disabled:
						if objs.id == id:
#							sprite.scale.x = 1.5
#							sprite.scale.y = 1.5
							if objs.get("is_parting_gift_rose") == true and split == false:
								var dir = xy_to_dir(get_fighter().current_di.x, get_fighter().current_di.y, "12")
								objs.change_state("Default")
								objs.set_vel(dir.x, dir.y)
								split = true
#								if current_state().current_tick == 0:
#									change_state("LargerBrasherHand")
								var obj = spawn_object(preload("res://_NokRuffian/characters/ruffian/projectiles/RuffianKnuckleduster_Split.tscn"), 0, 0)
								var obj2 = spawn_object(preload("res://_NokRuffian/characters/ruffian/projectiles/RuffianKnuckleduster_Split.tscn"), 0, 0)
								obj.apply_force(6 * get_facing_int(), 0)
								obj2.apply_force(6 * -get_facing_int(), 0)
								obj.set_facing(get_facing_int())
								obj2.set_facing(-get_facing_int())
								obj.sprite.set_material(sprite.get_material())
								obj2.sprite.set_material(sprite.get_material())
								objs.interact_count += 1
								disable()

func hit_by(hitbox):
	return
