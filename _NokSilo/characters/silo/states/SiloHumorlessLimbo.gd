extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func _enter():
	._enter()
	
	if "Aerial" in self.editor_description:
		self.apply_custom_grav = true
		self.apply_grav = false

func _frame_1():
	var dist = (float(data.x) / 100) * 3
	host.apply_force_relative("4", "0")
	host.apply_force(str(dist), "0")

func _frame_7():
	if "Grounded" in self.editor_description and host.is_grounded():
		host.apply_force_relative("0", "-8")

func _tick():
	._tick()

	if "Aerial" in self.editor_description and host.is_grounded() == true:
			var vel = host.get_vel()
			
			host.reset_momentum()
			host.set_vel(vel.x, str(-float(vel.y)))
			host.move_directly_relative("0", "-1")
			
			self.apply_custom_grav = false
			self.apply_grav = true
