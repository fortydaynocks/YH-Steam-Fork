extends "res://_NokDeoR/characters/deo/projectiles/DeoRStandState.gd"

var wait_time = 0
var max_wait_time = 20

func _enter():
	._enter()
	
	wait_time = 0

func _tick():
	._tick()
	
	
	if host.get_owner().blockstun_ticks < 1:
		wait_time += 1
			
	if wait_time >= max_wait_time:
		host.change_state("Callback")
		return
	
	#	--
	#if len(host.action_queue) > 0:
		#var check = false
		#var action = host.action_queue[0][0]
		#var pilot = host.action_queue[1][1]
		
		#if not cstate.get("actionable"):
			#check = false
		#elif (not cstate.get("self_cancellable")) and state == cstate.state_name:
			#check = false
		#elif cstate.get("active_iasa_on_hit") > 0 or cstate.current_tick < cstate.active_iasa_on_hit:
			#check = false
		
		#if host.buffer_action:
			#host.change_state("Dash", {"state": host.buffer_action[0], "pilot": host.buffer_action[1]})
			#host.buffer_action = null
			#
		#else:
			
