extends BaseProjectile

func tick():
	.tick()
	if not disabled:
		if current_tick % 5 == 0:
			play_sound("Rumble")
	if hitlag_ticks <= 0:
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
