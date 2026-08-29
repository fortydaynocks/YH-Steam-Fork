extends BaseProjectile

var parry_grace = 0

func tick():
	.tick()
	if not disabled:
		if current_tick % 5 == 0:
			play_sound("Rumble")
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
							if objs.get("is_parting_gift_rose") == true:
								var dir = xy_to_dir(get_fighter().current_di.x, get_fighter().current_di.y, "12")
								objs.change_state("Default")
								objs.set_vel(dir.x, dir.y)
