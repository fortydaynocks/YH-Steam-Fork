extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

var hit_count = 0
onready var end = $HitboxEnd
onready var loop = $HitboxLoop
var loop_vel = "0.0"
var true_hit_count = 0
var startup_reduction = 7

func _enter():
	._enter()
	loop.damage = 20
	loop.hitlag_ticks = 14
	loop.minimum_damage = 20
	loop.width = 24
	loop.height = 14
	loop.visible = true
	loop.active_ticks = 15

	end.width = 19
	end.height = 25

	endless = false
	hit_count = 0
	true_hit_count = 0
	startup_reduction = 7
	loop_vel = "0.0"
	
	host.play_sound("MeterSF3")
	self.interruptible_on_opponent_turn = false
#	host.stop_ticks += 15
#	host.cinestopped = true
#	host.global_hitlag(120, true)
##	hitlag_ticks += 100
#	if !host.is_ghost:
#		host.spawn_particle_effect_relative(preload("res://_NokRuffian/characters/ruffian/effects/RFSuperFlash.tscn"), Vector2(0, -18))
#		host.get_camera().focused_object = host
#		host.set_camera_zoom(0.60)
#		host.tween_camera_zoom(0.60, 0.55, 0.35, Tween.EASE_IN, Tween.EASE_IN)

func _frame_0():
	host.cinematic(45, 5)
	

func _frame_2():
	var dist = (data.x / 30) * (6 * host.get_facing_int())
	host.apply_force_relative("9.5", "0")
	host.apply_force(str(dist), "0")

func _frame_3():
	loop_vel = str(host.get_vel().x)

func _frame_4():
	host.start_projectile_invulnerability()
	
func _frame_15():
	host.end_projectile_invulnerability()

func _tick():
	._tick()


	if hitted == true:	
		if host.won == true:
			endless = false
			if host.opponent.hp <= 0 and host.opponent.is_grounded():
				host.change_state(fallback_state)
		if not host.is_ghost:
			Global.current_game.time += 1
		endless = true
		if current_tick in [9, 17]:
			host.set_vel(fixed.mul(loop_vel, "0.75"), "0")

		if current_tick == 25 and abs(host.get_pos().x) + (host.opponent.hurtbox.width/2) < abs(host.stage_width) - 50 and hit_count < 9:
			current_tick = startup_reduction
		while current_tick < loop.start_tick - 1 and true_hit_count > 5:
			host.state_tick()

	if current_tick == end.start_tick - 2 and hitted == true:
		host.opponent.set_pos(host.get_pos().x + 18, host.get_pos().y - 25)

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj is Fighter:
		host.start_invulnerability()
#		if (host.current_di.x != 69 and host.current_di.y != 69) or not host.infinite_resources:
#			hit_count += 1
		self.interruptible_on_opponent_turn = true
		if hitbox == end:
			host.reset_pushback()
			host.opponent.reset_pushback()
			host.opponent.start_invulnerability()
			loop.active_ticks = 15
			loop.deactivate()
#			if host.opponent.hp <= 0:
#				endless = false
		else:
			if host.opponent.hp < hitbox.damage:
				host.opponent.hp = 7
			loop.visible = false
			end.height = 1000
			end.width = 1000
			loop.width = 1000
			loop.height = 1000
			loop.active_ticks += 15
			if true_hit_count >= 5:
				startup_reduction = Utils.int_clamp(startup_reduction + 1, 10, 10)
			true_hit_count += 1
			loop_vel = fixed.mul(loop_vel, "1.1")
			for h in all_hitbox_nodes:
				if h.group != 1:
					h.hitlag_ticks = Utils.int_clamp(h.hitlag_ticks - 1, 0, 100)
		if host.opponent.hp <= hitbox.damage:
			loop.damage = 0

func on_got_blocked():
	.on_got_blocked()
	hitted = true
	if (host.current_di.x != 69 and host.current_di.y != 69) or not host.infinite_resources:
		hit_count += 3

func _exit():
	._exit()
	host.change_stance_to("Normal")
	if host.infinite_resources:
		host.super_meter = host.MAX_SUPER_METER
