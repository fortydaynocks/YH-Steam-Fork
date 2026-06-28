extends "res://_NokDurmak/characters/durmak/projectiles/DM-Projectile.gd"

export (int) var _c_walker
export (int) var max_hp = 2
export (bool) var lord = false
var hp = 2

var action_queue = []
var timeout = 0

#	--
func queue_action(action):
	if action in self.state_machine.states_map:
		action_queue.append(action)

func hit_by(hitbox):
	.hit_by(hitbox)
	
	hp -= 1
	
	if lord and hp > 0:
		self.hitlag_ticks += 6
		
	else:
		self.change_state("Hurt")
		action_queue = []
		
	
#	--
func _ready():
	._ready()
	
	state_variables.append_array(["hp", "action_queue", "timeout"])
	hp = max_hp

func tick():
	.tick()
	
	#	--	PREVENTING OVERLAPS WITH OTHER AGENTS
	for fellow in self.get_owner().objs_map.values():
		if is_instance_valid(fellow) and fellow != self and fellow.disabled != true and fellow.get_owner() == self.get_owner() and fellow.get("tag") and "Walker" in fellow.get("tag"):
			if self.collision_box.overlaps(fellow.collision_box):
				var displacement = fellow.get_pos().x - self.get_pos().x
				
				if displacement < 0:
					apply_force("0.5", "0")
				elif displacement > 0:
					apply_force("-0.5", "0")
				elif displacement == 0:
					apply_force(self.randi_choice(["-0.5", "0.5"]), "0")
					
	#	--	ACTION QUEUE
	if timeout <= 0 and len(action_queue) > 0:
		self.change_state(action_queue[0])
		action_queue.remove(0)
	
	if self.hitlag_ticks < 1:
		timeout = clamp(timeout - 1, 0, INF)
		
	#	--	DIE WHEN EXITING HITSTUN
	if self.hp <= 0:
		self.sprite.self_modulate = Color(0.5, 0.5, 0.5)
		self.start_invulnerability()
		
		if self.current_state().state_name in ["Default"]:
			self.play_sound("Vanish")
			self.spawn_particle_effect_relative(preload("res://_NokDurmak/characters/durmak/effects/DM-HitM.tscn"), Vector2(0, -18))
			self.disable()

func _process(d):
	._process(d)
	
	#	--	INFO DISPLAY
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
	if lord: $"%Info".bbcode_text += "[color=#d95763]Lord\n"
	$"%Info".bbcode_text += "[color=#7e7f87]HP: " + str(hp)
	
	if len(action_queue) > 0:
		var i = 0
		
		$"%Info".bbcode_text += "\nNext: [color=#d95763]"
		
		for action in action_queue:
			i += 1
			
			if i >= len(action_queue):
				$"%Info".bbcode_text += action
			else:
				$"%Info".bbcode_text += action + ", "
