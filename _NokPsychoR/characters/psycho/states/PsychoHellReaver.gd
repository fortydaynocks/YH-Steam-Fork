extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _frame_1():
	if host.initiative_effect == true:
		host.start_projectile_invulnerability()
		host.start_throw_invulnerability()
		
	self.land_cancel = false
		
func _frame_2():
	host.apply_force_relative("3", "-1")
		
func _frame_7():
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
		host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	
	host.reset_momentum()
	host.apply_force_relative("4", "-14")
		
func _frame_10():
	host.end_projectile_invulnerability()
	host.end_throw_invulnerability()
	
	self.land_cancel = false
	host.set_grounded(false)

func _tick():
	._tick()
	
	host.afterimage(Color(1, 0, 0, 0.75), 0.1)
