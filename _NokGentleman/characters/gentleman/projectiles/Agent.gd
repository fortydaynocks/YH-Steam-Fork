extends "res://_NokGentleman/characters/gentleman/projectiles/GM-Projectile.gd"

var is_gentleman_agent = true
var agent_name = "Agent"
var chase_radius = 100

func hit_by(hitbox:Hitbox):
	.hit_by(hitbox)
	
	self.disable()

#	--
func _process(delta):
	._process(delta)
	
	#	--	LABELS
	if is_instance_valid($"%Info"):
		
		$"%Info".visible = self.is_ghost
		$"%Info".bbcode_text = "[center]"

		$"%Info".bbcode_text += agent_name
		$"%Info".bbcode_text += "\n" + (self.current_state().state_name.capitalize() if self.current_state().get("action") == true else "No action")
		$"%Info".bbcode_text += "\n2 HP"
		
func tick():
	.tick()
	
	#	--	AGENT NAMING
	if self.current_tick == 1:
		var name_attempt = "Agent"
		var attempts = 1
		var satisfactory_name = false
		
		while satisfactory_name == false:
			satisfactory_name = true
			
			for fellow in self.get_owner().objs_map.values():
				if is_instance_valid(fellow) and self.get_owner().obj_from_name(fellow.obj_name) and fellow.get_owner() == self.get_owner() and fellow != self and fellow.get("tag") == "Agent":
					satisfactory_name = true
					if fellow.agent_name == name_attempt:
						satisfactory_name = false
						attempts += 1
						name_attempt = "Agent " + str(attempts)
		
		agent_name = name_attempt
	
	#	--	PREVENTING OVERLAPS WITH OTHER AGENTS
	for fellow in self.get_owner().objs_map.values():
		if is_instance_valid(fellow) and fellow != self and fellow.disabled != true:
			if fellow.get_owner() == self.get_owner() and fellow.get("is_gentleman_agent") == true:
				if self.collision_box.overlaps(fellow.collision_box):
					if self.current_state().get("pushable") == true and fellow.current_state().get("pushable") == true:
						var displacement = fellow.get_pos().x - self.get_pos().x
						
						if displacement < 0:
							apply_force("0.5", "0")
						elif displacement > 0:
							apply_force("-0.5", "0")
						elif displacement == 0:
							apply_force(self.randi_choice(["-0.5", "0.5"]), "0")
