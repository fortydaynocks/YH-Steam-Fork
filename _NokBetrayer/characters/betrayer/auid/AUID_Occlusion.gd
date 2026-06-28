extends ActionUIData

var selected_eye = null

#	--
func on_eye_switch_toggled(toggle, switch):
	emit_signal("data_changed")
	
	for eye_switch in $"%GridContainer".get_children():
		if switch.name != eye_switch.name:
			eye_switch.set_pressed_no_signal(false)
			
	if toggle == true:
		selected_eye = switch.editor_description
	else:
		selected_eye = null
			
#	--
func _ready():
	. _ready()
	
	for eye_switch in $"%GridContainer".get_children():
		eye_switch.connect("toggled", self, "on_eye_switch_toggled", [eye_switch])
	
func on_button_selected():
	.on_button_selected()
	
	var selected_eye = null
	
	$"%Eye1".disabled = true
	$"%Eye1".set_pressed_no_signal(false)
	$"%Eye1".text = "Nothing found"
	$"%Eye1".editor_description = ""
	
	$"%Eye2".disabled = true
	$"%Eye2".set_pressed_no_signal(false)
	$"%Eye2".text = "Nothing found"
	$"%Eye2".editor_description = ""
	
	$"%Eye3".disabled = true
	$"%Eye3".set_pressed_no_signal(false)
	$"%Eye3".text = "Nothing found"
	$"%Eye3".editor_description = ""
	
	var found_eyes = 0
	
	if self.fighter:
		for eye in self.fighter.objs_map.values():
			if self.fighter.obj_from_name(eye.obj_name) and eye.get_owner() == self.fighter and eye.get("tag") == "JudgeEye":
				found_eyes += 1
				
				if found_eyes == 1:
					$"%Eye1".disabled = false
					$"%Eye1".text = "Eye of " + str(eye.eye_type)
					$"%Eye1".editor_description = eye.obj_name
					
				if found_eyes == 2:
					$"%Eye2".disabled = false
					$"%Eye2".text = "Eye of " + str(eye.eye_type)
					$"%Eye2".editor_description = eye.obj_name
					
				if found_eyes == 3:
					$"%Eye3".disabled = false
					$"%Eye3".text = "Eye of " + str(eye.eye_type)
					$"%Eye3".editor_description = eye.obj_name

func get_data():
	return selected_eye
