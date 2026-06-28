extends CharacterState
#Nuion#9999's Drag Attack
#very useful for dragging or pushing enemies
#helps multihits quite a lot
export var _c_super_options = 0
export var is_super = false
export var super_level = 0
export var supers_used = 0
export var super_freeze_ticks = 0

export var _c_drag = 0
export var attacker_to_enemy = false
export var enemy_to_attacker = true
export var drag_force = "-1"
export var scale_with_combo = false
export var drag_start_tick = 0
export var drag_end_tick = 40
export var reset_per_tick = false

var stop_pull = false
var can_pull_yet = false

func is_usable():
	return .is_usable() and host.supers_available >= super_level

func _frame_1():
	stop_pull = false
	can_pull_yet = false

func _tick():
	if current_tick >= drag_start_tick:
		can_pull_yet = true
	if current_tick >= drag_end_tick:
		stop_pull = true

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if stop_pull == false and can_pull_yet == true:
		if reset_per_tick == true:
			host.set_vel("0","0")
			host.opponent.set_vel("0","0")
		if enemy_to_attacker == true:
			var enemy_pos = host.opponent.get_pos()
			var host_pos = host.get_pos()
			var diff = fixed.vec_sub(str(enemy_pos.x), str(enemy_pos.y), str(host_pos.x), str(host_pos.y))
			if scale_with_combo == true:
				var dir = fixed.normalized_vec_times(diff.x, diff.y, fixed.add(drag_force,fixed.mul(str(host.combo_count),"-0.21")))
				host.opponent.apply_force(dir.x, dir.y)
			else:
				var dir = fixed.normalized_vec_times(diff.x, diff.y, drag_force)
				host.opponent.apply_force(dir.x, dir.y)
		if attacker_to_enemy == true:
			var host_pos = host.opponent.get_pos()
			var enemy_pos = host.get_pos()
			var diff = fixed.vec_sub(str(enemy_pos.x), str(enemy_pos.y), str(host_pos.x), str(host_pos.y))
			if scale_with_combo == true:
				var dir = fixed.normalized_vec_times(diff.x, diff.y, fixed.add(drag_force,fixed.mul(str(host.combo_count),"-0.2")))
				host.apply_force(dir.x, dir.y)
			else:
				var dir = fixed.normalized_vec_times(diff.x, diff.y, drag_force)
				host.apply_force(dir.x, dir.y)
	if stop_pull == true:
		host.opponent.apply_forces_no_limit()


func _enter_shared():
	._enter_shared()
	if is_super == true:
		host.start_super()
		host.play_sound("Super")
		host.play_sound("Super2")
		host.play_sound("Super3")
		host.reset_momentum()
		for i in range(super_level if supers_used == - 1 else supers_used):
			host.use_super_bar()
