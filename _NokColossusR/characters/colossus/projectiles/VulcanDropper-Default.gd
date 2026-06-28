extends ObjectState

var mortar = preload("res://_NokColossusR/characters/colossus/projectiles/Mortar.tscn")
var chase_speed = 5
var chase_range = 25
var extra_spawn_height = 160
var mortar_speed = 10

var launch_at = 30

func _frame_1():
	$"%square".emitting = true
	$"%square2".emitting = true
	$"%wind".emitting = true
	$"%wind2".emitting = true
	
	if self.data and self.data is int:
		launch_at = self.data

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()
	var dist = pos.x - opos.x
	
	if abs(dist) > chase_range:
		if dist > 0:
			host.move_directly(str(-chase_speed), "0")
			
		if dist < 0:
			host.move_directly(str(chase_speed), "0")
	
	#	--
	if current_tick % 2 == 0 and current_tick <= launch_at:
		host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Misc1.tscn"), Vector2(0, opos.y - extra_spawn_height))

	if current_tick == launch_at:
		var obj = host.get_owner().spawn_object(mortar, pos.x, opos.y - extra_spawn_height, false, null, false)
		obj.set_grounded(false)
		obj.apply_force_relative("0", str(mortar_speed))
		obj.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-HitFlame.tscn"), Vector2(0, 0))
	
		host.play_sound("Launch")
		host.disable()
