extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var dist = 150
var gap = 40

func _frame_1():
	host.stress += 0.08

func _frame_7():
	var offset = (float(data.x) / 100) * 100
	
	var spikes = host.spawn_object(
		host.objs_table.MotherspikeSpawner,
		dist + offset,
		0,
		true,
		{"Gap": gap},
		true
		)
	
	spikes.move_directly_relative("0", str(host.ceiling_height))
	
	var flower = host.spawn_object(host.objs_table.Bloodflower, spikes.get_pos().x, 0, false, null, false)
	host.bloodflowers.append(flower.obj_name)

func _tick():
	._tick()
	
	if current_tick in [1, 4]:
		var offset = (float(data.x) / 100) * 100
		host.spawn_particle_effect_relative(host.vfx_table.Slash, Vector2(dist + offset, -float(host.get_pos().y)))
