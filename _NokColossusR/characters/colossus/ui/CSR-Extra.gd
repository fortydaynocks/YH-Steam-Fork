extends PlayerExtra

onready var flame_toggle = $"%FlameToggle"
onready var sword_toggle = $"%SwordToggle"

#	--
func reset():
	.reset()
	
	flame_toggle.pressed = false
	sword_toggle.pressed = false
	
	$"%FlameConversion".value = 0
	$"%ConvertSlider".value = 0
	
	$"%Quake".pressed = false
	$"%Quake".visible = false
	
	$"%Blade".pressed = false
	$"%Blade".visible = false
	
	if fighter:
		for obj in fighter.objs_map.values():
			if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == fighter and obj.get("tag") == "Quake":
				if obj.current_state().state_name == "Default":
					$"%Quake".visible = true
					
		if fighter.get("end_blade"):
			if fighter.obj_from_name(fighter.end_blade).current_state().state_name in ["Float", "Spin"] and fighter.obj_from_name(fighter.end_blade).attack_primed == false:
				$"%Blade".visible = true
	
	update_flame_conversion_ability()

func update_flame_conversion_ability():
	$"%FlameToggle".disabled = fighter.lordflame.Value < 1
	
	if fighter and $"%FlameToggle".disabled == true:
		$"%FlameToggle".disabled = $"%ConvertSlider".value < 1
		
	if $"%FlameToggle".disabled:
		$"%FlameToggle".text = "No Lordflames"
		$"%FlameToggle".pressed = false
			
	else:
		$"%FlameToggle".text = "Brandish the Flames"

#	--
func update_selected_move(move_state):
	.update_selected_move(move_state)
	
	if self.fighter:
		if self.selected_move and self.selected_move.get("can_armor") == true:
			$"%ArmorToggle".visible = true
			
			if self.fighter.fortitude.Value >= self.fighter.fortitude.ArmorCost:
				$"%ArmorToggle".disabled = false
				$"%ArmorToggle".text = "Use Armor"
				
			else:
				$"%ArmorToggle".disabled = true
				$"%ArmorToggle".pressed = false
				$"%ArmorToggle".text = "No Fortitude"
			
		else:
			$"%ArmorToggle".visible = false
			$"%ArmorToggle".pressed = false
	
func _process(delta):
	if self.fighter:
		var max_conversion = clamp(self.fighter.get_max_lordflames_possible(), 0, 9)
		var using_supers = 0
		
		if self.selected_move:
			if self.selected_move.super_level_ > 0 and self.fighter.infinite_resources != true:
				using_supers = self.selected_move.super_level_
				max_conversion = clamp(self.fighter.get_max_lordflames_possible() - using_supers * 2, 0, 9)
		
		$"%FlameConversion".max_value = max_conversion
		$"%ConvertSlider".max_value = max_conversion
		$"%MaxConversion".text = str($"%ConvertSlider".value) + "/" + str(max_conversion)
		$"%SupersWarning".visible = false
		$"%SupersWarning".text = ""
		
		if using_supers > 0:
			$"%MaxConversion".text += " !!"
			$"%SupersWarning".visible = true
			$"%SupersWarning".text = "(using " + str(using_supers) + "-bar super)"
		
		if max_conversion >= 1:
			$"%FCContainer".modulate = Color(1, 0.54, 0.2)
			
		else:
			$"%FCContainer".modulate = Color(0.2, 0.2, 0.2)
	
		#	--
		flame_toggle.visible = false; sword_toggle.visible = false
		if self.fighter.current_special_stance == "Flame": sword_toggle.visible = true
		if self.fighter.current_special_stance == "Sword": flame_toggle.visible = true
			
		#	--
		$"%ArmorToggle".get_node("Cost").visible = $"%ArmorToggle".pressed
		$"%ArmorToggle".get_node("Cost").text = "-" + str(self.fighter.fortitude.ArmorCost) + " Fortitude"

#	--
func get_extra():
	if is_instance_valid(flame_toggle) and is_instance_valid($"%FlameConversion"):
		return {
			"armor": $"%ArmorToggle".pressed,
			"flame": flame_toggle.pressed,
			"sword": sword_toggle.pressed,
			"conversion": $"%ConvertSlider".value,
			"quake": $"%Quake".pressed,
			"blade": $"%Blade".pressed,
		}
	
	return

#	--
func _on_ArmorToggle_pressed():
	self.emit_signal("data_changed")

func _on_FlameToggle_pressed():
	self.emit_signal("data_changed")
	
func _on_SwordToggle_pressed():
	self.emit_signal("data_changed")

func _on_FlameConversion_value_changed(value):
	self.emit_signal("data_changed")
	
	update_flame_conversion_ability()
	
#func _on_ConvertSlider_value_changed(value):
	#self.emit_signal("data_changed")
	
	#update_flame_conversion_ability()
	
func _on_ConvertSlider_drag_ended(value_changed):
	self.emit_signal("data_changed")
	
	update_flame_conversion_ability()
	
func _on_Quake_pressed():
	self.emit_signal("data_changed")

func _on_Blade_pressed():
	self.emit_signal("data_changed")





