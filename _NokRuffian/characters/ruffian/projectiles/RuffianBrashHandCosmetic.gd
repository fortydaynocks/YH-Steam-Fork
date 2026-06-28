extends BaseProjectile


func tick():
	.tick()
	var vel = get_vel()
	if get_fighter().opponent.combo_count > 0:
		disable()
	start_invulnerability()

	if "duck" in get_fighter().current_state().name and not "ex" in get_fighter().current_state().name:
		hitlag_ticks += 1


	if current_state().name == "Default":
		sprite.scale.x = 1.25
		sprite.scale.y = 1.25
		if hitlag_ticks <= 0:
			for objs in objs_map.values():
				if is_instance_valid(objs):
					if objs is BaseProjectile:
						if objs.hurtbox.overlaps(collision_box) and not objs.disabled:
							if objs.id == id:
								sprite.scale.x = 1.5
								sprite.scale.y = 1.5
								if objs.get("is_parting_gift_rose") == true:
									objs.interact_count += 1
									if current_state().current_tick == 0:
										change_state("LargerBrasherHand")
	if current_state().name == "LargerBrasherHand" and current_state().current_tick == 1:
		var opponent = get_fighter().opponent
		var opp_local = obj_local_center(opponent)
		var above_opp = {"x":opp_local.x, "y":opp_local.y}
		var nudge_force = str(Utils.int_clamp(fixed.round(distance_to(get_fighter().opponent)), -70, 70))
		var opp_dir = fixed.normalized_vec_times(str(above_opp.x), str(above_opp.y), nudge_force)
		move_directly(opp_dir.x, opp_dir.y)
