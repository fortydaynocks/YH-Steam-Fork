extends ObjectState

export (bool) var idle_state = false
export (bool) var hurt_state = false
export (float) var chase_x = 0
export (float) var chase_y = 0
export (int) var stop_chasing_at = -1
export (bool) var update_facing_on_enter = true
export (bool) var disable_on_exit = false

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()
	
	#	--	HURT STATE
	if host.get_owner().opponent.combo_count > 0 and not hurt_state:
		host.change_state("Hurt")
	
	#	--	STATE SWITCHING	
	if self.idle_state == true:
		if host.next_attack:
			if host.next_attack in host.state_machine.states_map:
				host.change_state(host.next_attack)
			
			host.next_attack = null
			
		else:
			host.disable()
			return
			
	#	--	UPDATE FACING
	if current_tick == 1:
		if update_facing_on_enter:
			host.set_facing(-1 if pos.x > opos.x else 1)
		
	#	--	OPPONENT CHASING
	if current_tick <= stop_chasing_at or stop_chasing_at == -1:
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		host.apply_force(str(vec.x * chase_x), str(vec.y * chase_y))
		
	if current_tick >= self.anim_length - 1 and disable_on_exit == true:
		host.disable()
