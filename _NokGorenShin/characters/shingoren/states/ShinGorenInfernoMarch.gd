extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var correction_speed = 10

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and host.is_grounded() != true:
		$"%Stuff".unlock_achievement("SG-AIR-INFERNO")

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.apply_force_relative("0", "-4")

func _frame_1():
	host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(-24, 0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(24, 0), Vector2(-host.get_facing_int(), 0))

func _frame_7():
	host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(-24, 0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(24, 0), Vector2(-host.get_facing_int(), 0))

func _tick():
	._tick()
	
	if not current_tick in [11, 12, 13, 14, 15, 16]:
		host.global_hitlag(1)
		
	if host.is_grounded() == false and current_tick <= 14:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		
		host.move_directly_relative("0", str(clamp(opos.y - pos.y, -correction_speed, correction_speed / 2)))

