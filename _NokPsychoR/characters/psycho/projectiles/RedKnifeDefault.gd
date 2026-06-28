extends ObjectState

var tpos: Vector2

func _frame_0():
	host.sprite.rotation_degrees = 90
	host.sprite.visible = false

func _frame_39():
	var pos = Vector2(host.get_pos().x, host.get_pos().y)
	tpos = Vector2(host.get_owner().opponent.get_pos().x, host.get_owner().opponent.get_pos().y - 18)
	
	if tpos:
		host.sprite.visible = true
		
		host.sprite.rotation_degrees = rad2deg(Vector2(tpos.x - pos.x, tpos.y - pos.y).angle())
		$"%stab".rotation_degrees = rad2deg(Vector2(tpos.x - pos.x, tpos.y - pos.y).angle())
		
		host.play_sound("Aim")
		host.play_sound("Aim2")

func _frame_49():
	if tpos:
		host.play_sound("Swing")

func _frame_58():
	if tpos:
		host.set_pos(str(tpos.x), str(tpos.y))
		
		$"%stab".emitting = true
		$"%blood".emitting = false
		host.sprite.visible = false
		
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn"), Vector2(0, 0))

func _tick():
	._tick()
	
	if host.get_owner().opponent.combo_count >= 1:
		host.disable()
	
	if current_tick >= 65:
		$"%blood".emitting = false
		host.disable()
