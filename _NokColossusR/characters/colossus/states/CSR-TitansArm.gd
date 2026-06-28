extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	host.reset_momentum()
	host.apply_force_relative("2", "0")

func _frame_1():
	if host.initiative:
		host.start_throw_invulnerability()

func _frame_14():
	host.afterimage(Color(1, 1, 1, 0.5), 0.25)

func _frame_15():
	host.end_throw_invulnerability()
	host.apply_force_relative("8", "0")

func _tick():
	._tick()
	
	if current_tick in [15, 16, 17]:
		if abs(host.opponent.get_pos().x - host.get_pos().x) >= 60 and host.reverse_state != true:
			host.move_directly_relative("60", "0")
	
		host.afterimage(Color(1, 1, 1, 0.5), 0.1)
