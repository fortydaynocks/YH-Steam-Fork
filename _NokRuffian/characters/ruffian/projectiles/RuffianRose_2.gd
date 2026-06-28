extends BaseProjectile



func tick():
	.tick()
	start_invulnerability()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj is Fighter:
		get_fighter().gain_super_meter_raw(get_fighter().MAX_SUPER_METER)
		get_fighter().current_state().enable_hit_cancel()
		if current_state().name == "Default" and fixed.gt(get_vel().y, "0"):
			apply_force_relative(fixed.mul(get_vel().x, "-0.75"), fixed.mul(get_vel().y, "-2"))
#			if get_fighter().combo_count <= 0:
#				get_fighter().opponent.hitlag_ticks += 2
#			else:
#				get_fighter().opponent.hitlag_ticks += 4
#
#func hit_by(hitbox):
#	.hit_by(hitbox)
#	var thing = obj_from_name(hitbox.host)
#	if thing:
#		if thing == get_fighter():
#			if current_state().name != "Default":
#				change_state("Default")
#			apply_force(get_fighter().current_di.x/5, get_fighter().current_di.y/9)
#			set_grounded(false)
#			set_facing(get_fighter().get_facing_int())
#			hitlag_ticks = 0
#			if get_fighter().current_state().endless == false:
#				get_fighter().feinting = true
#
#
#func disable():
#	.disable()
#	get_fighter().can_followup = false
