extends ActionUIData

func _on_Mode_toggled(button_pressed):
	self.emit_signal("data_changed")
	
	$Mode.text = "Recoil"
	if button_pressed: $Mode.text = "Lodge"
