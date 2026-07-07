extends "res://_NokJupiter/characters/jupiter/states/JupiterState.gd"

onready var neuron = preload("res://_NokJupiter/characters/jupiter/projectiles/Neuron.tscn")
var shoot_speed = 2
var spawn_radius = 100

func _frame_6():
	var dir = xy_to_dir(data["Direction"].x, data["Direction"].y, str(spawn_radius))
	
	var obj = host.spawn_object(neuron, int(dir.x), int(dir.y) - 18, false, null, true)
	obj.set_grounded(false)
	
	var vec = Vector2(obj.get_pos().x - host.get_pos().x, obj.get_pos().y - host.get_pos().y).normalized()
	
	obj.apply_force(str(shoot_speed * vec.x), str(shoot_speed * vec.y))
	
	if data["Static"] == true and host.static_elec.Value > 0:
		host.static_elec.Value -= 1
		host.static_elec.Recover = 0
		
		obj.static_neuron = true
