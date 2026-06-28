extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var speed = 20

func _enter():
	._enter()
	
	self.apply_fric = false
	self.apply_grav = false
	self.apply_custom_x_fric = true
	self.apply_custom_y_fric = true

func _frame_1():
	host.stress -= 0.09

func _frame_6():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()	
	var vec = Vector2(float(opos.x) - float(pos.x), float(opos.y) - float(pos.y)).normalized()
	
	host.reset_momentum()
	host.apply_force(str(vec.x * speed), str(vec.y * speed))

func _frame_38():
	self.apply_fric = true
	self.apply_grav = true
	self.apply_custom_x_fric = false
	self.apply_custom_y_fric = false

func _tick():
	._tick()
	
	if current_tick <= 30:
		host.afterimage(Color.red, 0.05)
