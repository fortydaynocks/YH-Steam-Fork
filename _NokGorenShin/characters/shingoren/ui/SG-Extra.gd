extends PlayerExtra

var max_dist = 350
var max_step_dist = 300

#	--
func get_extra():
	return {
		"Firewalk": $"%Firewalk".pressed,
		"Firewarp": $"%Firewarp".pressed,
		"Mark": $"%Mark".pressed and not $"%Mark".disabled,
		"DemonStep": $"%DemonStep".pressed and not $"%DemonStep".disabled and not $"%Mark".pressed,
		"CCEnd": $"%CCEnd".pressed and $"%CCEnd".visible,
	}

#	--
func update(recheck = false):
	if recheck:
		$"%Firewalk".pressed = false
		$"%Firewarp".pressed = false
		$"%Mark".pressed = false
		$"%DemonStep".pressed = false
	
	$"%Firewalk".disabled = true
	$"%Firewarp".visible = false
	$"%Firewarp".disabled = false
	
	$"%Mark".visible = false
	$"%Mark".disabled = true
	$"%MarkDetails".text = ""
	
	$"%DemonStep".visible = false
	$"%DemonStep".disabled = true
	$"%DemonStepDetails".text = ""
	
	if self.fighter:
		$"%CCEnd".visible = self.fighter.get("cc") == true
		
		#	--	FIREWALK
		if self.selected_move and (not "NoFirewalk" in fighter.current_state().editor_description):
			if fighter.firewalk.Value > 0:
				$"%Firewalk".disabled = fighter.firewalk.Value > 0
			
		#	--	FIREWARP
		if self.selected_move:
			for obj in self.fighter.objs_map.values():
				if is_instance_valid(obj) and obj.disabled != true and obj.creator == self.fighter and obj.get("tag") == "Fireswirl":
					$"%Firewarp".visible = true
					
					if "NoFirewarp" in self.selected_move.editor_description:
						$"%Firewarp".pressed = false
						$"%Firewarp".disabled = true

func reset():
	.reset()
	
	if self.fighter:
		if self.fighter.was_my_turn:
			update(true)

func update_selected_move(move_state):
	.update_selected_move(move_state)
	
	update()
	
	if fighter:
		if fighter.firewalk.Value > 0:
			$"%Firewalk".disabled = false
		
		#	--	MARK
		if fighter.supers_available >= 1:
			$"%Mark".visible = true
			
			var opp_dist = int(fighter.distance_to(fighter.opponent))
				
			if opp_dist <= max_dist:
				$"%Mark".disabled = false
				
			else:
				$"%Mark".disabled = true
				$"%MarkDetails".text = "Too far..."
				
			if move_state and move_state.get("supers_used_") + 1 > fighter.supers_available:
				$"%Mark".disabled = true
				$"%MarkDetails".text = "Not enough meter..."
				
			if move_state and ("NoMark" in move_state.editor_description or move_state.get("type") in [4, 5]):
				$"%Mark".disabled = true
				$"%MarkDetails".text = "Invalid action..."
				
		#	--	DEMON STEP	
		if fighter.get("active_mark") and is_instance_valid(fighter.objs_map.get(fighter.active_mark)):
			var mark = fighter.objs_map[fighter.active_mark]
			$"%DemonStep".visible = true
			
			var mark_dist = int(fighter.distance_to(mark))
			
			if mark_dist <= max_step_dist:
				$"%DemonStep".disabled = false
				
			else:
				$"%DemonStep".disabled = true
				$"%DemonStepDetails".text = "Too far..."
			
			if (not move_state) or "NoDemonStep" in move_state.get("editor_description") or ((not move_state.get("type") in [1, 2, 3]) and not "CanDemonStep" in move_state.get("editor_description")):
				$"%DemonStep".disabled = true
				$"%DemonStepDetails".text = "Invalid action..."

#	--
func _on_Firewalk_pressed():
	emit_signal("data_changed")

func _on_Firewarp_pressed():
	emit_signal("data_changed")

func _on_Mark_pressed():
	emit_signal("data_changed")
	
	if $"%Mark".pressed == true and $"%DemonStep".pressed == true:
		$"%DemonStep".pressed = false

func _on_DemonStep_pressed():
	emit_signal("data_changed")
	
	if $"%DemonStep".pressed == true and $"%Mark".pressed == true:
		$"%Mark".pressed = false

func _on_CCEnd_pressed():
	emit_signal("data_changed")






