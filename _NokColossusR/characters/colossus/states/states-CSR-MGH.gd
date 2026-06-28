extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var chase_dist = 40
	
func _frame_2():
	host.start_throw_invulnerability()
	
func _frame_3():
	host.start_projectile_invulnerability()
	
func _frame_6():
	host.reset_momentum()
	host.apply_force_relative("4", "-10")
	host.move_directly_relative("0", "-40")

func _frame_10():
	host.end_throw_invulnerability()
	host.end_projectile_invulnerability()

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.apply_force("0", "-10")
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
func _tick():
	._tick()
	
	if current_tick <= 6 and abs(host.opponent.get_pos().x - host.get_pos().x) >= chase_dist:
		host.move_directly_relative("10", "0")
	
	if current_tick < 7:
		host.global_hitlag(2)
	
	if current_tick >= 7:
		host.apply_force_relative("0", "0.25")
	
	host.afterimage(Color(1, 1, 1, 0.5), 0.1)

