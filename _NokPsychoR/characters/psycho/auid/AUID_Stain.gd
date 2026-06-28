extends ActionUIData

func _process(delta):
	
	if fighter:
		$"%Feed".disabled = fighter.wounds < 5
		$"%FeedEX".disabled = fighter.wounds < 10
		
func get_data():
	return {
		"Place": $"%Place".get_data(),
		"Feed": $"%Feed".pressed and not $"%Feed".disabled,
		"FeedEX": $"%FeedEX".pressed and not $"%FeedEX".disabled,
	}


func _on_Feed_pressed():
	emit_signal("data_changed")
	$"%FeedEX".pressed = false
	
func _on_FeedEX_pressed():
	emit_signal("data_changed")
	$"%Feed".pressed = false
