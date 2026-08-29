extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var redirected = false
var chase = false
var launch_force = 16
var chase_force = 2

#	--
func is_usable():
	return .is_usable() and host.infinite_resources

#	--
func redirect(proj):
	self.interruptible_on_opponent_turn = true
	
	host.reset_momentum()
	var dir = xy_to_dir(host.current_di.x, host.current_di.y, str(launch_force))
	host.apply_force(dir.x, dir.y)
	
	host.play_sound("WW-Redirect")
	host.play_sound("WW-Redirect2")
	
	host.global_hitlag(8)
	print(proj.get_owner())
	if proj.get_owner() == host.opponent:
		host.opponent.hitlag_ticks = 8
	
	host.spawn_particle_effect_relative(
		preload("res://_NokGorenShin/characters/shingoren/effects/SG_Pushblock.tscn"),
		Vector2(0, -18))
		
func redirect_chase():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	host.apply_force(str(vec.x * chase_force), str(vec.y * chase_force))

#	--
func _frame_0():
	redirected = false
	self.interruptible_on_opponent_turn = false

func _frame_6():
	host.start_projectile_invulnerability()
	
func _frame_18():
	if !redirected:
		host.end_projectile_invulnerability()
	
func _tick():
	._tick()
	
	if !redirected and host.projectile_invulnerable:
		for proj in host.objs_map.values():
			if is_instance_valid(proj) and !proj.disabled and !proj is Fighter:
				if proj.collision_box.overlaps(host.hurtbox):
					proj.immunity_susceptible = true
					proj.current_state().terminate_hitboxes()
					
					redirect(proj)
					chase = true
					redirected = true
	
	if chase:
		redirect_chase()
