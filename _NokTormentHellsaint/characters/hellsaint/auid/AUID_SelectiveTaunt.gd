extends ActionUIData

func get_data():
	return {
		"Text": ProfanityFilter.filter($"%TauntText".text),
		"Emote": $"%Emote".get_value(),
		"Skip": $"%TauntSkip".pressed,
	}

#	--
func _on_TauntUpdate_pressed():
	self.emit_signal("data_changed")

func _on_TauntClear_pressed():
	$"%TauntText".text = ""
	self.emit_signal("data_changed")

func _on_TauntSkip_pressed():
	self.emit_signal("data_changed")

func _on_Emote_data_changed():
	self.emit_signal("data_changed")
