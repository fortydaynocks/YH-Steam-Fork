extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var stain = preload("res://_NokPsychoR/characters/psycho/projectiles/Stain.tscn")
var spawn_fx = preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn")
var base_dist = 100
var mod_dist = 100

func _frame_4():
	var dir = xy_to_dir(data["Place"].x, data["Place"].y, str(mod_dist))
	
	var obj = host.spawn_object(stain, (base_dist * host.get_facing_int()) + int(dir.x), int(dir.y) - 18, false, null, true)
	obj.spawn_particle_effect_relative(spawn_fx, Vector2(0, 0))

	if data["Feed"] == true:
		obj.stain_type = "Bloodstain"
		host.wounds -= 5
	
	if data["FeedEX"] == true:
		obj.stain_type = "Bloodwash"
		host.wounds -= 10

func _frame_9():
	if host.combo_count > 0:
		self.enable_interrupt()
