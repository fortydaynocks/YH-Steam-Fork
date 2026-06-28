extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var target_vfx = preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar1.tscn")
var consume_fx = preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn")

var dist = 200
var clean_strike_threshold = 80

onready var hitbox = $"%HitboxClean"

func is_usable():
	var found_stains = 0
	
	for stain in host.objs_map.values():
		if is_instance_valid(stain) and stain.disabled != true and stain.get("tag") == "Stain" and stain.creator == host:
			found_stains += 1
	
	return .is_usable() and found_stains > 0

func _frame_5():
	var dir = xy_to_dir(data.x, data.y, str(dist))
	
	if is_instance_valid(hitbox):
		hitbox.x = int(dir.x) * host.get_facing_int()
		hitbox.y = int(dir.y) - 18
		
	if host.is_ghost:
		host.spawn_particle_effect_relative(target_vfx, Vector2(int(dir.x) * host.get_facing_int(), int(dir.y) - 18))

func _frame_6():
	if is_instance_valid(hitbox):
		for stain in host.objs_map.values():
			if is_instance_valid(stain) and stain.disabled != true and stain.get("tag") == "Stain" and stain.creator == host:
				if stain.hurtbox.overlaps(hitbox):
					host.play_sound("StainFound")
					host.play_sound("StainFound2")
					
					if stain.get("stain_type") == "Stain":
						host.spawn_particle_effect_relative(consume_fx, Vector2(0, -18))
						host.afterimage(host.extra_color_1, 0.25)
						host.set_pos(stain.get_pos().x, stain.get_pos().y)
						host.update_facing()
						
						var pos = host.get_pos()
						var opos = host.opponent.get_pos()
						
						if Vector2(opos.x - pos.x, opos.y - pos.y).length() <= clean_strike_threshold:
							host.set_pos(opos.x, opos.y)
							host.set_facing(-host.opponent.get_facing_int())
							host.move_directly_relative("80", "0")
							host.change_state("cleanstrike")
					
					stain.activate_stain()
					stain.spawn_particle_effect_relative(consume_fx, Vector2(0, 0))
					
					return
