extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var dist = 6

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and host.counterhit_this_turn == true:
		$"%Stuff".unlock_achievement("SG-HEIGHT")

func on_got_perfect_parried():
	.on_got_perfect_parried()
	
	self.iasa_at = -1

func _frame_0():
	self.iasa_at = 35

func _frame_2():
	var dir = (float(data.x + 100) / 100) * dist
	host.apply_force_relative(str(dir), "0")
	
	if host.initiative == true:
		host.start_throw_invulnerability()
	
func _frame_7():
	host.reset_momentum()
	host.apply_force_relative("2", "-12")
	host.set_grounded(false)

func _frame_12():
	host.end_throw_invulnerability()

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8, 9]:
		host.move_directly_relative("2", "-10")
	
	if current_tick <= 12:
		host._create_speed_after_image(Color("ff8933"), 0.1)
