extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

onready var hbox = $Hitbox
var initial_dist = 60
var dist = 40
var max_height = 100

func is_usable():
	if "Air" in self.editor_description:
		return .is_usable() and host.get_pos().y >= -max_height
	return .is_usable()

func _frame_8():
	var pos = host.get_pos()
	
	if hbox:
		host.spawn_particle_effect_relative(
			preload("res://_NokSickness/characters/sickness/effects/SC-ShadowTendrils.tscn"),
			Vector2(hbox.x, -pos.y ),
			Vector2(host.get_facing_int(), 0)
			)

func _tick():
	._tick()
	
	var dir = (data.x * 0.01) * dist
	var pos = host.get_pos()
	
	if hbox:
		hbox.x = initial_dist + dist + dir
		hbox.y = -pos.y - 10
