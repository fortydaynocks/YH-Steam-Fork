extends Fighter

var buffers = {
	"Pilot": null
}

var charname = "Skullmage"

var link = {
	"Value": 0,
	"Max": 2,
}

var necro_target = null

#	-------------------------------------------------------------------------- |
func afterimage(color:Color = Color.white, lifetime = 0.2):
	self._create_speed_after_image(color, lifetime)

func summon_entity(summon, placement):
	if not (summon and placement): return
	var spawn_dist = 150
	
	var entity = self.spawn_object(summon, placement.x, placement.y, false, null, true)
	entity.set_grounded(false)
	entity.set_facing(self.get_facing_int())
	entity.sprite.material = self.sprite.material

#	-------------------------------------------------------------------------- |
func process_extra(extra):
	.process_extra(extra)
	
	if extra.get("Pilot"):
		buffers.Pilot = extra.Pilot
		
#	-------------------------------------------------------------------------- |
func init(pos = null):
	.init(pos)
	#$"%Stuff"._start()
	
	self.melee_attack_combo_scaling_applied = false

func tick():
	.tick()
	
	#	--	TEST
	#if self.current_tick == 1:
		#grant_opponent_state($StateMachine/test_state)
	
	#	--	VALUE SETTING
	link.Value = clamp(link.Value, 0, link.Max)
	
	#	--	SUMMON WEIGHT
	link.Value = 0
	for summon in self.objs_map.values():
		if is_instance_valid(summon) and summon.disabled != true and summon.get_owner() == self and summon.get("is_summon") == true:
			link.Value += summon.get("summon_weight")
		
	#	--	NECROSIS CLEANUP
	if necro_target and not self.obj_from_name(necro_target):
		necro_target = null
		
	#	--	NECROSIS
	if necro_target:
		var necro_target_obj = self.obj_from_name(necro_target)
		
		if self.current_state().current_tick >= 2 and buffers.Pilot and (buffers.Pilot.x != 0 or buffers.Pilot.y != 0):
			if necro_target_obj.current_state() and necro_target_obj.current_state().get("action_state") != true:
				necro_target_obj.change_state("Move", buffers.Pilot)
				
				buffers.Pilot = null

func _process(delta):
	._process(delta)
	
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
		
	#	--	LINK
	if link.Value >= link.Max:
		$"%Info".bbcode_text += "\n[color=#ff4444]Link: " + str(link.Value) + "/" + str(link.Max) + " [/color]"
	
	else:
		$"%Info".bbcode_text += "\n[color=#9c85cc]Link: " + str(link.Value) + "/" + str(link.Max) + " [/color]"
