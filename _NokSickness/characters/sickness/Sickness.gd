extends Fighter

var charname = "Sickness"

var illness = {
	"value": 0,
	"max": 20
}

var disease = {
	"value": 0,
	"max": 20,
	"stages": [0, 5, 10, 15]
}

#	========================================================================== |
func afterimage(color:Color = Color.white, lifetime = 0.2):
	if color == Color("#006aff") and self.applied_style and self.applied_style.get("extra_color_1"):
		color = self.applied_style.get("extra_color_1")
	
	self._create_speed_after_image(color, lifetime)

func increment_property(property, inc):
	if inc == 0: return
	
	if property.has("value") and property.has("max"):
		property.value = clamp(property.value + inc, 0, property.max)

#	========================================================================== |
func on_state_changed(states_stack):
	.on_state_changed(states_stack)
	
	if self.previous_state():
		if "> pretty" in self.previous_state().interrupt_into_string or "> pretty" in self.previous_state().interrupt_from_string:
			afterimage(Color("#ffa6b6"), 0.2)

func _tick():
	._tick()
	
	

func _process(d):
	._process(d)
	
	#	--	INFO DISPLAY
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	$"%Info".bbcode_text += "[color=#806065]Illness: %s[/color]\n" % str(illness.value)
	if disease.value > 0: $"%Info".bbcode_text += "[color=#ffa6b6]Disease: %s[/color]\n" % str(disease.value)
	
	#	--	TENTACLES
	$"%Tentas".visible = true
	$"%Tentas".animation = "tentas"
	$"%Tentas".playing = self.hitlag_ticks <= 0
	$"%Tentas".speed_scale = 1
	
	$"%Tentas".position.y = -self.get_pos().y
	if self.opponent.combo_count >= 1: $"%Tentas".speed_scale = 4
	
	
