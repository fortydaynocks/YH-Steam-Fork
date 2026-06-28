extends PlayerExtra

onready var activate_judge_eye = $"%ActivateJudgeEye"
onready var pass_judgement = $"%PassJudgement"
var selected_eye = null
var too_many_eyes = false
var can_use_activ = true
var allowed_pass_activ = true

#	--
func eye_type_switch_toggled(toggle, switch):
	selected_eye = null
	
	#	--
	for eye_type_switch in $"%EyeTypes".get_children():
		if not switch.name == eye_type_switch.name:
			eye_type_switch.set_pressed_no_signal(false)
			
	if toggle == true:
		selected_eye = switch.editor_description
			
	emit_signal("data_changed")

func verify_activ_usability(move_state):
	if move_state:
		if can_use_activ == true:
			$"%Judge Eye".modulate = Color("#006aff")
			$"%Judge Eye".get_node("Label").text = "Judge Eye"
			
			allowed_pass_activ = true
			
			if move_state:	
				if (move_state.get("type") in [4, 5] or "ForceNoEye" in move_state.editor_description) and (not "ForceEye" in move_state.editor_description):
					allowed_pass_activ = false
					$"%Judge Eye".modulate = Color("#808080")
					$"%Judge Eye".get_node("Label").text = "Invalid state..."

#	--
func _ready():
	._ready()
	
	for eye_type_switch in $"%EyeTypes".get_children():
		eye_type_switch.connect("toggled", self, "eye_type_switch_toggled", [eye_type_switch])

func reset():
	.reset()
	
	selected_eye = null
	can_use_activ = true
	allowed_pass_activ = true
	
	if self.fighter:
		$"%Judge Eye".reset()
		
		var found_eyes = 0
		too_many_eyes = false
		
		for found_eye in fighter.objs_map.values():
			if fighter.obj_from_name(found_eye.obj_name) and found_eye.get_owner() == fighter and found_eye.get("tag") == "JudgeEye":
				found_eyes += 1
				
		$"%Judge Eye".modulate = Color("#006aff")
		$"%Judge Eye".get_node("Label").text = "Judge Eye"

		if found_eyes >= self.fighter.judgepoints.MaxEyes:
			too_many_eyes = true
			$"%Judge Eye".modulate = Color("#808080")
			$"%Judge Eye".get_node("Label").text = "Too many eyes..."
			
			can_use_activ = false
			
		if self.fighter.judgepoints.Value <= 0:
			$"%Judge Eye".modulate = Color("#808080")
			$"%Judge Eye".get_node("Label").text = "No Judge Points..."
			
			can_use_activ = false

	if self.fighter:
		for eye_type_switch in $"%EyeTypes".get_children():
			eye_type_switch.set_pressed_no_signal(false)

			var eye_count = fighter.eyepoints.get(eye_type_switch.editor_description)
			if eye_count != null:
				eye_type_switch.text = str(eye_count[0])
				eye_type_switch.disabled = eye_count[0] <= 0
				
			if self.fighter.judgepoints.Value <= 0 or too_many_eyes:
				eye_type_switch.disabled = true
				
		verify_activ_usability(fighter.current_state())

func show_options():
	.show_options()
	
	pass_judgement.pressed = false
	
	activate_judge_eye.clear()
	activate_judge_eye.add_item("select Judge Eye...")

	if is_instance_valid(fighter):
		for eye_name in fighter.eyes:
			var eye = fighter.objs_map[eye_name]
			
			if is_instance_valid(eye) and eye.disabled != true and eye.get("judge_eye") == true and eye.get("inconsolable") == false:
				if fighter.blades[eye.eye_type] == true:
					activate_judge_eye.add_item(eye.eye_type)
					
func update_selected_move(move_state):
	.update_selected_move(move_state)
	
	verify_activ_usability(move_state)
				
#	--			
func _process(delta):
	var JEdata = $"%Judge Eye".get_data()
	
	if self.fighter:
		$"%EyeTypes".visible = (JEdata.get("x") != 0 or JEdata.get("y") != 0)
		$"%EyeTypesLabel".visible = $"%EyeTypes".visible

#	--	
func get_extra():
	var JEdata = $"%Judge Eye".get_data()
	if (JEdata and JEdata.get("x") == 0 and JEdata.get("y") == 0) or too_many_eyes or can_use_activ == false or allowed_pass_activ == false:
		JEdata = null
	
	var extra = {
		"activate_judge_eye": activate_judge_eye.get_item_text(activate_judge_eye.selected) if activate_judge_eye.selected else null,
		"pass_judgement": pass_judgement.pressed,
		"JudgeEye": JEdata,
		"JudgeEyeType": selected_eye,
	}
	return extra

#	--
func _on_ActivateJudgeEye_item_selected(index):
	emit_signal("data_changed")

func _on_PassJudgement_pressed():
	emit_signal("data_changed")

func _on_Judge_Eye_data_changed():
	emit_signal("data_changed")
