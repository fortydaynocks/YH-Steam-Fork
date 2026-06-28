extends PlayerExtra

func get_extra():
	return {
		"Slumber": $"%Slumber".pressed
	}

#	--
func reset():
	.reset()
	
#	--
func _on_Slumber_pressed(): self.emit_signal("data_changed")
