extends "res://_NokSkullmage/characters/skullmage/projectiles/SK-Proj.gd"

export (int) var summon_weight = 1
export (int) var max_hp = 1
export (int) var hp_bar_length = 30
var skullmage_summon = true
var hp = 1

var action_queue = []
var timeout = 0

#	--
func _ready():
	._ready()
	
	state_variables.append_array(["skullmage_summon", "hp", "action_queue", "timeout"])

#	--
func queue_action(action):
	if action in self.state_machine.states_map:
		action_queue.append(action)

func hit_by(hitbox):
	if hitbox.host == self.get_opponent().obj_name:
		hp -= 1
		
		self.get_opponent().current_state().allow_framecheat = false
		self.get_opponent().projectile_free_cancel()
		
		if hp <= 0:
			self.disable()

#	--
func _init():
	._init()
	
	hp = max_hp

func tick():
	.tick()
	
	#	--
	if timeout <= 0 and len(action_queue) > 0:
		self.change_state(action_queue[0])
		action_queue.remove(0)
		
	#	--
	timeout = clamp(timeout - 1, 0, INF)
		
func _process(delta):
	._process(delta)
	
	$"%Info".visible = self.is_ghost and self.disabled != true
	$"%Info".bbcode_text = "[center]"
	
	$"%Info".bbcode_text += self.tag
	$"%Info".bbcode_text += "\n[color=#9c85cc]Weight: " + str(summon_weight) + "[/color]"
	
	$"%HPContainer".visible = self.is_ghost and self.disabled != true
	$"%HPCount".bbcode_text = "[center]" + str(hp)
	$"%HPBar".value = hp
	$"%HPBar".max_value = max_hp
	
	$"%HPContainer".position.x = -(hp_bar_length / 2)
	$"%HPBar".rect_size.x = hp_bar_length
	$"%HPCount".rect_size.x = hp_bar_length
