extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

const max_x_vel = "12"
var hit_ground = true
var speed_increase = {
	x = "0.60",
	y = "3.5"
}

func _frame_1():
	if not host.is_grounded():
		host.apply_force_relative(1, -3)

func _tick():
	._tick()
	if fixed.gt(host.get_vel().y, "0.0") and not host.is_grounded():
		host.set_vel_relative(fixed.add(host.get_vel().x, speed_increase.x), fixed.add(host.get_vel().y, speed_increase.y))
		if fixed.ge(host.get_vel().x, max_x_vel):
			speed_increase.x = "0.0"
		else:
			speed_increase.x = "0.60"
	if current_tick % 2 == 0:
		host.global_hitlag(1, true)
	if current_tick == (2 * tpf) + 1:
		if not host.is_grounded():
			current_tick -= 1
	if host.is_grounded():
		hit_ground = true
	if current_tick == 3 * tpf and hit_ground == true:
		var obj = host.spawn_object(preload("res://_NokRuffian/characters/ruffian/projectiles/RuffianKnuckleduster.tscn"), 20, 0)
		obj.apply_force(fixed.mul("8", str(host.get_facing_int())), "0")
		obj.set_facing(host.get_facing_int())
		obj.sprite.set_material(host.sprite.get_material())
		var obj2 = host.spawn_object(preload("res://_NokRuffian/characters/ruffian/projectiles/RuffianKnuckleduster.tscn"), -20, 0)
		obj2.apply_force(fixed.mul("-8", str(host.get_facing_int())), "0")
		obj2.set_facing(-host.get_facing_int())
		obj2.sprite.set_material(host.sprite.get_material())
