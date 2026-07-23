extends Fighter

var charname = "Venerator"

#	========================================================================= >
var voyage = {
	"turns_left": 0,
	"enabled": false,
	"dir": null,
	"strength": 0.5,
	"ticks": 0,
}

#	========================================================================= >
func afterimage(color:Color = Color.white, lifetime = 0.2):
	if color == Color("#006aff") and self.applied_style and self.applied_style.get("extra_color_1"):
		color = self.applied_style.get("extra_color_1")
	
	self._create_speed_after_image(color, lifetime)

#	========================================================================= >
func process_extra(extra):
	.process_extra(extra)

	if voyage.turns_left > 0 and voyage.enabled == false:
		voyage.turns_left -= 1
			
		self.spawn_particle_effect_relative(
			preload("res://fx/FeintEffect.tscn"),
			Vector2(0, -18)
		)
			
		if voyage.turns_left == 0:
			voyage.enabled = true
			voyage.ticks = 20
				
			self.reset_momentum()

func tick():
	.tick()
	
	#	--	VOYAGE
	if voyage.enabled == true:
		if voyage.dir and voyage.ticks > 0:
			var pos = self.get_pos()
			var opos = self.opponent.get_pos()
			var dir = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
			
			self.apply_force(str(dir.x * voyage.strength), str(dir.y * voyage.strength))
			self.apply_forces_no_limit()
			voyage.ticks -= 1
			
			afterimage(Color("#ff8933"), 0.1)
			afterimage(Color("#ffee83"), 0.05)
		else:
			voyage.enabled = false
			voyage.dir = null

func _process(d):
	._process(d)
	
	#	--	IDLE FLOAT
	var visual_float_offset = sin(current_tick * 0.1) * 3
	
	if self.current_state().state_name in ["Wait"]:
		self.sprite.offset.y = lerp(self.sprite.offset.y, -18 + visual_float_offset, 0.25)
		
	else:
		self.sprite.offset.y = lerp(self.sprite.offset.y, -18, 0.1)
