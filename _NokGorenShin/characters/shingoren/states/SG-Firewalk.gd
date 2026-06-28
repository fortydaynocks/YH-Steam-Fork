extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var initial_speed = 4
var speed = 10
var dist = null
var distY = null

#func get_interrupt_exceptions():
	#var new_interrupt_ex = .get_interrupt_exceptions()
	#new_interrupt_ex.append(self._previous_state_name())
	
	#return new_interrupt_ex

func _frame_0():
	host.reset_momentum()
	
	self.interrupt_exceptions = get_categories(interrupt_exceptions_string)
	self.interrupt_exceptions.append(self._previous_state_name())
	
	if host.combo_count > 0:
		host.opponent.hitlag_ticks += 2
	
	dist = (float(host.current_di.x) / 100) * speed
	distY = (float(host.current_di.y) / 100) * speed
	
	host.apply_force_relative(str(initial_speed), "0")
	host.apply_force(str(dist), "0")
	
	if not host.is_grounded():
		host.apply_force("0", str(distY))
	
	host.play_sound("Firewalk")
	host.play_sound("Firewalk2")
	
	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit3.tscn"), Vector2(0, -18))

func _frame_9():
	if host.combo_count > 0:
		self.enable_interrupt()
	
func _tick():
	._tick()
	
	if current_tick in [1, 2, 3, 4] and dist and distY:
		host.move_directly(str(dist), "0")

	host.afterimage(Color("#ff8933"), 0.1)
		
	if current_tick > 0:
		host.update_facing()
