extends "res://_NokDeoR/characters/deo/projectiles/DeoR-Projectile.gd"

var actionable = true
var buffer_action = null
var can_disable = false

var action_queue = []
var idle_time = [0, 20]

#	--
#func request_action(state, pilot = null):
	#var check = true
	#var cstate = self.current_state()
	
	#if cstate:
		#if not cstate.get("actionable"):
			#check = false
		#elif (not cstate.get("self_cancellable")) and state == cstate.state_name:
			#check = false
		#elif cstate.get("active_iasa_on_hit") > 0 or cstate.current_tick < cstate.active_iasa_on_hit:
			#check = false
	
	#if check and cstate:
		#self.change_state("Dash", {"state": state, "pilot": pilot})
	
	#else:
		#buffer_action = [state, pilot]

func queue_action(state = "", pilot = null):
	if not self.state_machine.get_node(state): return
	
	action_queue.append([state, pilot])
		
func activate_action(info: Array):
	if not info: return
	
	var state = info[0]
	var pilot = info[1]
	
	if pilot:
		self.change_state("Dash", {"state": state, "pilot": pilot})
	
	else:
		self.change_state(state)
		
		
#	--
func disable():
	if can_disable == true:
		self.get_owner().stand_values.Stand = null
		buffer_action = []
		
		.disable()
	
#	--
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	#if hit_fighter_last() == true:
		#self.creator.hitlag_ticks = hitbox.hitlag_ticks
		
func hit_by(hitbox):
	.hit_by(hitbox)
	
	self.get_owner().take_damage(75)
	self.change_state("Callback")
		
#	--
func tick():
	.tick()

	
	#	--
	if self.get_owner().blockstun_ticks > 0:
		
		#	--	BLOCKSTUN FREEZE TO PREVENT UNFAIR BLOCKSTRINGS
		self.hitlag_ticks = self.get_owner().blockstun_ticks
			
	else:
		var cstate = self.current_state()
		
		#	--	DECAY TIMER
		if idle_time[0] >= idle_time[1]:
			self.change_state("Callback")
		
		if self.current_state().state_name in ["Default"]:
			idle_time[0] += 1
		else:
			idle_time[0] = 0
		
		#	--	ACTION SELECTION
		if cstate.get("actionable"):
			if len(action_queue) > 0:
				var check = true
				if (not cstate.get("self_cancellable")) and action_queue[0][0] == cstate.state_name: check = false
				
				if check:
					activate_action(action_queue.pop_front())
			
	#	--
	#var overlapping_opp_hbox = false
	#for opp_hbox in self.get_owner().opponent.get_active_hitboxes():
		#if opp_hbox.overlaps(self.hurtbox) and (not opp_hbox.hitbox_type in [4, 5, 6]):
			#overlapping_opp_hbox = true
			#break
	
	#if self.get_owner().opponent.combo_count > 0 or overlapping_opp_hbox:
		
		#if not self.current_state().state_name == "Callback":
			#self.change_state("Callback")
			
			#self.play_sound("GotHit")
			#self.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Hit1.tscn"), Vector2(0, -18))
			#self.get_owner().opponent.projectile_free_cancel()
			
			#self.rumble(2, 10)
			#self.global_hitlag(4)
			
			#self.get_owner().take_damage(75)
			
func _process(delta):
	._process(delta)
	
	$"%Info".visible = self.is_ghost and (self.disabled != true)
	$"%Info".bbcode_text = "[center]"
	
	$"%Info".bbcode_text += "Current: " + (self.current_state().state_name if self.current_state().get("action") == true else "...")
	$"%Info".bbcode_text += "\nNext: " + (buffer_action[0] if buffer_action else "...")
