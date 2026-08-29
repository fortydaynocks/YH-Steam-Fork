extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var dist = 6

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and host.counterhit_this_turn == true:
		$"%Stuff".unlock_achievement("SG-HEIGHT")

func on_got_perfect_parried():
	.on_got_perfect_parried()
	
	self.iasa_at = -1

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.apply_force_relative("0", "-6")

func _frame_0():
	self.iasa_at = 47

func _frame_2():
	var dir = (float(data.x + 100) / 100) * dist
	host.apply_force_relative(str(dir), "0")
	
	if host.initiative == true:
		host.start_throw_invulnerability()
	
func _frame_4():
	host.apply_force_relative("2", "-4")
	
func _frame_19():
	host.reset_momentum()
	host.apply_force_relative("2", "-12")
	host.set_grounded(false)

func _frame_24():
	host.end_throw_invulnerability()

func _tick():
	._tick()
	
	if current_tick in [18, 19, 20, 21]:
		host.move_directly_relative("2", "-10")
	
	if current_tick <= 24:
		host._create_speed_after_image(Color("cc2f7b"), 0.1)
