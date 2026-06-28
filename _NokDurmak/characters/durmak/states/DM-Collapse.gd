extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

onready var hbox = $"%Hitbox-Collapse"

func _frame_0():	#	--	AIR GROUND BOUNCE SPAM PREVENTION
	if is_instance_valid(hbox):
		hbox.air_ground_bounce = true
		
		var moves_used = host.combo_moves_used.keys()
		
		if self.state_name in moves_used:
			if host.combo_moves_used[self.state_name] > 1:
				
				hbox.air_ground_bounce = false

func _frame_1():
	host.apply_force_relative("0", "-6")
	
func _frame_12():
	host.reset_momentum()
	host.apply_force_relative("0", "20")
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent:
		if host.current_di.y < 0:
			host.reset_momentum()
			host.apply_force_relative("2", "-6")
	
func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	var force = -0.5 if pos.x > opos.x else 0.5
	host.apply_force(str(force), "0")
