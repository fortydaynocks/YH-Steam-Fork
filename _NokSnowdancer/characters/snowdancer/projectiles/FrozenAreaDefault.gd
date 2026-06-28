extends ObjectState

var div = 0.06
var lifespan = 130

func _tick():
	._tick()
	
	if current_tick >= lifespan:
		host.disable()
	
	if is_instance_valid($"%ContactLabel"):
		if current_tick >= lifespan - 1:
			$"%ContactLabel".text = "Disabled"
		
		else:
			$"%ContactLabel".visible = host.is_ghost
			
			if host.contact_left:
				$"%ContactLabel".text = "Contact left: " + str(host.contact_left[0]) + "f"
				
			else:
				if host.creator.opponent.invulnerable == true or host.creator.opponent.projectile_invulnerable == true:
					$"%ContactLabel".text = "Opponent invulnerable..."
					
				else:
					$"%ContactLabel".text = "No contact..."
	
	var pos = host.get_pos()
	var opos = host.creator.opponent.get_pos()
	
	var new_x = lerp(pos.x, opos.x, div)
	host.set_pos(str(new_x), str(pos.y))
	
	#	--
	if host.hurtbox.overlaps(host.creator.opponent.hurtbox) and host.creator.opponent.invulnerable == false and host.creator.opponent.projectile_invulnerable == false:
		if host.contact_left:
			host.contact_left[0] -= 1
			
			if host.contact_left[0] < 1:
				
				host.creator.spawn_object(host.creator.objs_table.IceThorn, host.creator.opponent.get_pos().x, pos.y, false, null, false)
				host.contact_left = []
			
		else:
			host.contact_left = [host.contact_restart_time, host.creator.opponent.get_pos().x - pos.x]
	else:
		host.contact_left = []
