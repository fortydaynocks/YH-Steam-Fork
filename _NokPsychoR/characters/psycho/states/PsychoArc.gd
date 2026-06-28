extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var dist = 75

func _frame_1():
	if data == true:
		host.apply_force_relative("6", "0")

func _frame_2():
	host.start_projectile_invulnerability()
	host.start_throw_invulnerability()
	
func _frame_10():
	host.afterimage(Color(1, 0, 0, 1), 0.25)
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var dir = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	var length = clamp(Vector2(opos.x - pos.x, opos.y - pos.y).length(), 0, dist)
	host.move_directly(str(dir.x * length), str(dir.y * (length if not host.is_grounded() else 0)))
	host.apply_force_relative("6", "0")
	
func _frame_11():
	host.end_throw_invulnerability()
	host.end_projectile_invulnerability()
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if host.wounds < host.minimum_h_wounds:
		host.wounds += 10
		
func on_got_blocked():
	.on_got_blocked()
	
	host.scars += 8

func _tick():
	._tick()
	
	if current_tick <= 4:
		host.global_hitlag(1)
