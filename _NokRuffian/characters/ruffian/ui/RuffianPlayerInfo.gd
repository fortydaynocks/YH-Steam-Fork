extends PlayerInfo

var tick = 0
var pressed = false
var pressed2 = false
var scrolling = false
onready var guide = $AlignBox/VBoxContainer/VBoxContainer2/GuideText

func set_fighter(fighter):
	.set_fighter(fighter)
	fighter.player_info = self
	if player_id == 2:
		$AlignBox.alignment = BoxContainer.ALIGN_END
	else:
		$AlignBox.alignment = BoxContainer.ALIGN_BEGIN

func _process(delta):
	._process(delta)
	tick += 1
	if not is_instance_valid(fighter):
		return
	$"%Volume".text = "Volume = " + str($AlignBox/VBoxContainer/Volume/Direction.value + 25) if $AlignBox/VBoxContainer/Volume/Direction.value > -25 else "Muted"
	if ReplayManager.playback:
		$AlignBox.get_node("VBoxContainer").rect_position.y = -225
		$AlignBox.rect_position.x = 100
		$AlignBox.rect_min_size.x = 125
		$AlignBox.rect_size.x = 125
	else:
		$AlignBox.get_node("VBoxContainer").rect_position.y = 20
		$AlignBox.rect_position.x = 50
		$AlignBox.rect_min_size.x = 170
		$AlignBox.rect_size.x = 170

	if $AlignBox/VBoxContainer/VBoxContainer2/Weave.pressed:
		if not pressed:
			pressed = true
			pressed2 = false
			scrolling = false
			guide.percent_visible = 0.00
			$AlignBox/VBoxContainer/VBoxContainer2/Corkscrew.set_pressed_no_signal(false)
		guide.text = """Weave toggle lets
Ruffian cancel his
recovery to enter
a single-use stance.
This stance is highly
commital, as Ruffian
is forced to attack
upon use."""
	else:
		if pressed:
			pressed = false
			scrolling = false
			guide.percent_visible = 0.00

	if $AlignBox/VBoxContainer/VBoxContainer2/Corkscrew.pressed:
		if not pressed2:
			pressed2 = true
			pressed = false
			scrolling = false
			guide.percent_visible = 0.00
			$AlignBox/VBoxContainer/VBoxContainer2/Weave.set_pressed_no_signal(false)
		guide.text = """If Ruffian is close to a
rose from Parting Gift,
He can cancel the
STARTUP of any attack
to perform Corkscrew
Blow."""
	else:
		if pressed2:
			pressed2 = false
			scrolling = false
			guide.percent_visible = 0.00


	guide.visible = $AlignBox/VBoxContainer/VBoxContainer2/Weave.pressed or $AlignBox/VBoxContainer/VBoxContainer2/Corkscrew.pressed
	$AlignBox/VBoxContainer/VBoxContainer2.visible = $AlignBox/VBoxContainer/GuideBase.pressed
	if not $AlignBox/VBoxContainer/VBoxContainer2.visible:
		$AlignBox/VBoxContainer/VBoxContainer2/Corkscrew.set_pressed_no_signal(false)
		$AlignBox/VBoxContainer/VBoxContainer2/Weave.set_pressed_no_signal(false)

	$AlignBox/VBoxContainer/Volume.visible = fighter.skin > 0
	if $AlignBox/VBoxContainer/VBoxContainer2/Weave.pressed or $AlignBox/VBoxContainer/VBoxContainer2/Corkscrew.pressed:
		if scrolling == false and guide.percent_visible < 1.00:
			guide.percent_visible += 0.01
#			if $AlignBox/VBoxContainer/VBoxContainer2/Weave.pressed:
#				guide.percent_visible += 0.02
#			elif $AlignBox/VBoxContainer/VBoxContainer2/Corkscrew.pressed:
#				guide.percent_visible += 0.01
		elif scrolling == false and guide.percent_visible >= 1.00:
			scrolling = true


func _on_Volume_data_changed():
	emit_signal("data_changed")
	fighter.bgm.volume_db = $AlignBox/VBoxContainer/Volume/Direction.value if $AlignBox/VBoxContainer/Volume/Direction.value > -25 else -100
	
