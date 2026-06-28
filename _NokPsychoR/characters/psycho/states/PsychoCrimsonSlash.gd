extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

export (PackedScene) var slash
export (PackedScene) var big_slash
export (PackedScene) var star
export (PackedScene) var big_star

var shots = 0
var limit = 9999

func _enter():
	._enter()
	
	host.spawn_particle_effect_relative(big_star, Vector2(0, -18))
	shots = 0
	
	limit = data.x - 1

func _frame_1():
	host.hitlag_ticks = 2
	
func _tick():
	._tick()
	
	var fac = host.get_facing_int()
	
	if current_tick in [8, 14, 20]:
		
		#	--
		
		host.play_sound("CrimsonSlashSwing")
		host.spawn_particle_effect_relative(star, Vector2(64, -18))
		
		if host.wounds > 0:
			var obj = host.spawn_object(slash, 36, -18, true, null, true)
			obj.set_grounded(false)
			obj.set_facing(fac)
			obj.apply_force(str(35 * fac), str(host.randi_range(0, -2)))
			
			host.hitlag_ticks = 2
	
	if current_tick in [10, 16, 22]:
		if host.wounds > 0 and shots < 9 and shots < limit:
			host.wounds -= 2
			shots += 1
		else:
			current_tick = 22
	
	if current_tick == 22:
		if host.wounds > 0 and shots < 9 and shots < limit:
			current_tick = 8
			
	if current_tick > 22 and current_tick < 32:
		host.global_hitlag(1)
				
	if current_tick == 32:		
		host.play_sound("CrimsonSlashSwing")
		host.screen_bump(Vector2(0, 0), 12, 0.5)
		host.spawn_particle_effect_relative(big_star, Vector2(128, -18))
		
		var obj = host.spawn_object(big_slash, 36, -18, true, null, true)
		obj.set_grounded(false)
		obj.set_facing(fac)
		obj.apply_force(str(20 * fac), "0")
