extends ActionUIData

func get_data():
	return {
		"Direction": $"%Direction".get_data(),
		"Short": $"%ShortToggle".pressed,
	}

func _on_ShortToggle_pressed():
	emit_signal("data_changed")

func _process(delta):
	if self.fighter and not $"%Direction".get_data() is String:
		match $"%Direction".get_data().x:
			1:
				$"%StanceLabel".bbcode_text = "State: [color=#FF0000]Torture's Knell"
				
			-1:
				$"%StanceLabel".bbcode_text = "State: [color=#FF8888]Misery's Knell"
