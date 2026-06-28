extends BaseProjectile

export var is_parting_gift_rose = true
var interact_count = 0
var hit_by_creator_count = 0
var hit_by_opponent_count = 0



func tick():
	.tick()
	start_projectile_invulnerability()
	if interact_count >= 2:
		disable()
	start_projectile_invulnerability()
	if collision_box.overlaps(get_fighter().hurtbox):
		get_fighter().in_range = true
	else:
		get_fighter().in_range = false
		
	if get_fighter().attacking == true:
		start_invulnerability()
	else:
		end_invulnerability()

	if get_fighter().current_state().name == "victory":
		if current_state().name == "Planted":
			current_state().lifetime = 9999
		else:
			current_state().lifetime = 50

	if get_fighter().current_state().name == "partinggift" or get_fighter().current_state().name == "corkscrewblow":
		if get_fighter().current_state().current_tick == 1:
			disable()
	if current_state().name == "Default":
		collision_box.y = 1
		hurtbox.y = 1
	else:
		collision_box.y = -8
		hurtbox.y = -8

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if current_state().name == "Default" and fixed.gt(get_vel().y, "0"):
		if obj is Fighter:
			apply_force_relative(fixed.mul(get_vel().x, "-0.75"), fixed.mul(get_vel().y, "-2"))
			if get_fighter().combo_count <= 0:
				get_fighter().opponent.hitlag_ticks += 2
			else:
				get_fighter().opponent.hitlag_ticks += 4

func hit_by(hitbox):

	var thing = obj_from_name(hitbox.host)
	if thing:
		if thing is Fighter:
			change_state("Default")
			set_grounded(false)
			set_facing(thing.get_facing_int())
			thing.hitlag_ticks = 0
			hitlag_ticks = 0
			var dir = xy_to_dir(thing.current_di.x, thing.current_di.y, "6.9")
			set_vel(dir.x, dir.y)
			if thing.current_state().endless == false and not "Burst" in thing.current_state().name:
				if hit_by_creator_count < 2 and thing.id == id:
					thing.feinting = true
					hit_by_creator_count += 1
				if hit_by_opponent_count < 2 and thing.id != id:
					thing.feinting = true
					hit_by_opponent_count += 1
			
			.hit_by(hitbox)
		else:
			return
			
func disable():
	.disable()
	get_fighter().can_followup = false
