extends ActionUIData


func _process(delta):
	if fighter.get_pos().y >= -30:
		$Direction.limit_angle = true
		$Direction.limit_range_degrees = 180
		$Direction.limit_center_degrees = -90
	else:
		$Direction.limit_angle = false
