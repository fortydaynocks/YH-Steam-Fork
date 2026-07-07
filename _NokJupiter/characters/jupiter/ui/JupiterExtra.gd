extends PlayerExtra



#	--
func _on_CheckButton_pressed():
	emit_signal("data_changed")

func _on_Flash_pressed():
	emit_signal("data_changed")

#	--
func show_options():
	.show_options()
	
	$"%Stream".pressed = false
	$"%Flash".pressed = false

func get_extra():
	return {
		"stream": $"%Stream".pressed and $"%Stream".visible,
		"flash": $"%Flash".pressed and $"%Flash".visible,
	}
