extends ActionUIData

func _on_Attack_pressed(): self.emit_signal("data_changed")

func get_data():
	return {
		"Position": $Position.get_data(),
		"Attack": $Attack.pressed,
	}
