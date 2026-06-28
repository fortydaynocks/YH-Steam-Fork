extends PlayerExtra

onready var weave = $"%Weave"
onready var attack = $"%Followup"
var exceptions = ["partinggift", "chargestepdash"]
var cant_weave = ["friendlyhandshake", "JumpGrab", "AirGrab", "Grab", "jetupper", "blastchain", "rollingthunder"]
var weave_states = ["duck", "duck2"]

func show_options():
	show_stuff()
#	if not fighter.busy_interrupt:
	weave.set_pressed_no_signal(false)
	attack.set_pressed_no_signal(false)

func show_stuff():

	if not is_instance_valid(fighter):
		return

	if fighter.opponent.combo_count <= 0 and fighter.current_state() and not fighter.current_state() is ThrowState and (fighter.current_state().type != CharacterState.ActionType.Defense):
		if selected_move:
			# UNIVERSAL CONDITIONS FOR WEAVE AND CORKSCREW TOGGLE WITH SELECTED MOVE
			if not "Burst" in selected_move.name and selected_move.endless == false:
				# WEAVE CONDITIONS WITH SELECTED MOVE
				if (selected_move.earliest_hitbox > 0 or selected_move.name == "partinggift") and not selected_move.name in cant_weave and fighter.current_state() and not fighter.current_state().name in weave_states:
					weave.disabled = false
				else:
					weave.disabled = true
					weave.set_pressed_no_signal(false)
				# CORKSCREW CONDITIONS WITH SELECTED MOVE
				if fighter.can_followup == true and (selected_move.earliest_hitbox > 0 or selected_move.name == "chargestepdash"):
					attack.disabled = false
				else:
					attack.disabled = true
					attack.set_pressed_no_signal(false)
			else:
				weave.disabled = true
				weave.set_pressed_no_signal(false)
				attack.disabled = true
				attack.set_pressed_no_signal(false)
		elif fighter.current_state():
			var cs = fighter.current_state()
			# WEAVE CONDITIONS FOR NO SELECTED MOVE
			if not cs.name in cant_weave and (cs.earliest_hitbox > 0 or cs.name == "partinggift"):
				weave.disabled = false
			else:
				weave.disabled = true
				weave.set_pressed_no_signal(false)
			# CORKSCREW CONDITIONS FOR NO SELECTED MOVE
			if fighter.can_followup == true and (cs.earliest_hitbox > 0 or cs.name == "chargestepdash"):
				attack.disabled = false
			else:
				attack.disabled = true
				attack.set_pressed_no_signal(false)
	else:
		attack.disabled = true
		attack.set_pressed_no_signal(false)
		weave.disabled = true
		weave.set_pressed_no_signal(false)

#		if selected_move:
#			if (selected_move.earliest_hitbox > 0 or selected_move.name == "partinggift") and not "Burst" in selected_move.name and fighter.current_state() and fighter.current_state().name != "duck" and not selected_move.name in ["friendlyhandshake", "JumpGrab", "AirGrab", "Grab", "jetupper", "blastchain", "rollingthunder"]:
#				weave.disabled = false
#			else:
#				weave.disabled = true
#				weave.set_pressed_no_signal(false)
#			if selected_move and ((not "Burst" in selected_move.name and selected_move.earliest_hitbox > 0 and selected_move.endless == false) or selected_move.name == "jetstream") and fighter.can_followup == true:
#				attack.disabled = false
#			else:
#				attack.disabled = true
#				attack.set_pressed_no_signal(false)
#		else:
#			if fighter.current_state() and fighter.current_state().type != CharacterState.ActionType.Defense and fighter.current_state().name != "duck" and fighter.current_state().earliest_hitbox > 0 and not ("Parry" in fighter.current_state().name and fighter.parried == false):
#				weave.disabled = false
#				if fighter.can_followup == true and not selected_move:
#					attack.disabled = false
#				else:
#					attack.disabled = true
#					attack.set_pressed_no_signal(false)
#			else:
#				weave.disabled = true
#				weave.set_pressed_no_signal(false)
#				attack.disabled = true
#				attack.set_pressed_no_signal(false)


#	else:
#		attack.disabled = true
#		attack.set_pressed_no_signal(false)
#		weave.disabled = true
#		weave.set_pressed_no_signal(false)



func get_extra():
	show_stuff()
	return{
		"Weaving": weave.pressed,
		"Followup": attack.pressed,
	}

func _ready():
	$"%Weave".connect("pressed", self, "weave_pressed")
	$"%Followup".connect("pressed", self, "attack_pressed")

func weave_pressed():
	emit_signal("data_changed")
	attack.set_pressed_no_signal(false)
func attack_pressed():
	emit_signal("data_changed")
	weave.set_pressed_no_signal(false)


#func _process(delta):
#	if fighter.busy_interrupt:
#		weave.set_pressed_no_signal(fighter.weaving)
#		attack.set_pressed_no_signal(fighter.attacking)
#	if weave.visible == false or fighter.busy_interrupt or weave.disabled == true:
#		weave.set_pressed_no_signal(false)
#	if attack.visible == false or fighter.busy_interrupt or attack.disabled == true:
#		attack.set_pressed_no_signal(false)
#	attack.set_pressed_no_signal(fighter.attacking)
