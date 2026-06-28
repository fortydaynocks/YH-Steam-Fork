extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

var duped = false
var master_distance_mod = 0
onready var hitbox = $Hitbox
onready var hitbox2 = $Hitbox2
var started_ground = false

func _enter():
	._enter()
	if host.initiative:
		no_collision_start_frame = 9
	else:
		no_collision_start_frame = 12
	master_distance_mod = 0
	duped = false
#	hitbox.guard_break = not _previous_state_name() in ["cover", "duck", "duck2"]
#	hitbox2.guard_break = not _previous_state_name() in ["cover", "duck", "duck2"]
#	hitbox.block_punishable = _previous_state_name() == "exduck"
	if _previous_state_name() in ["cover", "duck", "duck2", "exduck", "excover"]:
		hitbox.damage_proration = 2
		hitbox.hard_knockdown = true
		hitbox2.damage_proration = 2
		hitbox2.hard_knockdown = true
	else:
		hitbox.damage_proration = 0
		hitbox.hard_knockdown = false
		hitbox2.damage_proration = 0
		hitbox2.hard_knockdown = false

func _frame_0():

	if data:
		if data["Down"] == true:
			if host.get_pos().y >= -1 or host.is_grounded():
				started_ground = true
			else:
				started_ground = false
		else:
			started_ground = false
	else:
		started_ground = false

	if _previous_state_name() == "cover":
		current_tick = 4
	elif _previous_state_name() in ["duck", "duck2", "exduck", "excover"]:
		current_tick = 3

func _frame_2():
	host.reset_momentum()
	host.apply_force_relative("-7", "0")


#func _frame_2():
#	if _previous_state_name() == "exduck":
#		if host.initiative:
#			host.start_throw_invulnerability()

func _frame_3():
#	duped = abs(float(host.opponent.get_pos().x)) - float(host.get_pos().x) <= 60
	
#	if duped == true and host.reverse_state == true:
#	if not _previous_state_name() in ["duck", "cover"]:
#		if abs(host.get_pos().x - host.opponent.get_pos().x) <= 60:
#			host.move_directly_relative(abs(host.get_pos().x - host.opponent.get_pos().x) * -1, 0)
#		else:
#			host.move_directly_relative(-60, 0)
		
		host.spawn_particle_effect_relative(timed_particle_scene, Vector2(0, 0), Vector2(-host.get_facing_int(), 0))
	
func _frame_9():
	host.screen_bump(Vector2(), 0.4, 0.4)
	host.trail("EX")
	
	host.reset_momentum()
	
	if _previous_state_name() in ["duck", "duck2"]:
		master_distance_mod = 60
	elif _previous_state_name() == "cover":
		master_distance_mod = 100
	else:
		master_distance_mod = 160
	

	
	if started_ground == true:
		host.move_directly_relative(0, -45)
#		hitbox.guard_break = false
#		hitbox2.guard_break = false
	
	if abs(host.get_pos().x - host.opponent.get_pos().x) <= master_distance_mod:
		host.move_directly_relative(abs(host.get_pos().x - host.opponent.get_pos().x), 0)
	else:
		host.move_directly_relative(master_distance_mod, 0)
	host.reset_momentum()
	host.apply_force_relative(5, 0)
	
#	if duped == true:
#		host.move_directly_relative("40", "0")
#		host.apply_force_relative("8", "0")
#	else:
#		host.move_directly_relative("100", "0")
#		host.apply_force_relative("12", "0")

func _tick():
	._tick()
	if current_tick > 0 and current_tick <= 7:
		if data:
			if data["Down"] == true:
				host.move_directly_relative(0, 7)

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if _previous_state_name() in ["exduck", "excover"]:
		host.opponent.hitlag_ticks += hitbox.hitlag_ticks/2
