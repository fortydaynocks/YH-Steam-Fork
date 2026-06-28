extends ActionUIData

func get_data():
	var data = false
	
	if is_instance_valid($"%CheckButton") and is_instance_valid(self.fighter):
		$"%CheckButton".disabled = true
		
		if self.fighter.supers_available >= 1 and self.fighter.combo_count < 1:
			$"%CheckButton".disabled = false
			return $"%CheckButton".pressed
			
	return data

func _on_CheckButton_pressed():
	emit_signal("data_changed")
