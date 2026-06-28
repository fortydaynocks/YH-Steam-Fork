extends PlayerExtra

var target = null
var place_dist = null

var dist = 150

#	--	
func retarget():
	if self.fighter:
		var fpos = self.fighter.get_pos()
		var targeting_dist = fpos.x + ($"%Array".value * self.fighter.get_furthest_spike_array()[1])
	
		if self.fighter.get_closest_array(targeting_dist):
			target = self.fighter.get_closest_array(targeting_dist).obj_name
		
func replace():
	place_dist = null
	
	$"%PlaceContainer".visible = false
	$"%PlaceContainer".modulate = Color(0.5, 0.5, 0.5)
	$"%Place".editable = false
	$"%PlaceLabel".text = "Place"
	$"%PlaceLabel".disabled = true
	
	if self.fighter:
		if self.fighter.terminus:
			$"%PlaceContainer".visible = true
			
			var chosen_move = self.selected_move if self.selected_move else self.fighter.current_state()
			
			#	--
			if self.fighter.free_array_place_cooldown > 0:
				$"%PlaceLabel".text = "Cooldown: " + str(self.fighter.free_array_place_cooldown)
				return
			if chosen_move.get("type") in [4, 5]:
				$"%PlaceLabel".text = "Cannot place"
				return
			if "CannotPlace" in chosen_move.get("editor_description"):
				$"%PlaceLabel".text = "Cannot place"
				return
			if len(self.fighter.get_spike_arrays()) >= 3:
				$"%PlaceLabel".text = "Too many exist (" + str(len(self.fighter.get_spike_arrays())) + ")"
				return
				
			$"%PlaceContainer".modulate = Color(1, 1, 1)
			$"%Place".editable = true
			$"%PlaceLabel".disabled = false
			
			if $"%PlaceLabel".pressed and (not $"%PlaceLabel".disabled):
				place_dist = $"%Place".value * dist
			
#	--
func reset():
	.reset()
	
	$"%ArrayContainer".visible = false
	$"%DisableArray".visible = false
	$"%DisableArray".pressed = false
	target = null
	place_dist = null
	
	#	--
	if self.fighter:
		if self.fighter.get_spike_arrays():
			$"%ArrayContainer".visible = true
			$"%DisableArray".visible = true
			$"%DisableArray".disabled = self.fighter.current_state().get("needs_array") == true
			
			retarget()
			
		replace()
			
			
			
func update_selected_move(move_state):
	.update_selected_move(move_state)
	
	if move_state:
		$"%DisableArray".disabled = move_state.get("needs_array") == true
		
	replace()
	
#	--
func _on_Place_drag_ended(value_changed):
	self.emit_signal("data_changed")
	replace()

func _on_PlaceLabel_pressed():
	self.emit_signal("data_changed")
	replace()

func _on_Array_drag_ended(value_changed):
	self.emit_signal("data_changed")
	retarget()
			
func _on_DisableArray_pressed():
	self.emit_signal("data_changed")
			
#	--
func get_extra():
	return {
		"targeted_array": target,
		"place_array": place_dist,
		"disable_array": $"%DisableArray".pressed and $"%DisableArray".visible and (not $"%DisableArray".disabled)
	}



