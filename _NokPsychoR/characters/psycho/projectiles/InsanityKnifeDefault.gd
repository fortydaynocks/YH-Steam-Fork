extends DefaultFireball

onready var hbox = $"%hbox"

func _frame_1():
	host.variety = host.randi_choice(host.varietychoices)
	anim_name = "knife" + host.variety
	
func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.creator.opponent.get_pos()
	var dir = Vector2(float(opos.x) - float(pos.x), (float(opos.y) - float(pos.y)) - 18).normalized()
	
	if current_tick < 20:
		host.sprite.rotation_degrees = rad2deg(dir.angle())

func _frame_19():
	hbox.damage = int(host.dmg * host.multiplier)
	hbox.minimum_damage = int(hbox.damage * (1/3))
	
	var rot = deg2rad(host.sprite.rotation_degrees)
	
	var hbox_angle = Vector2(cos(rot) * 150, sin(rot) * 150)
		
	hbox.to_x = hbox_angle.x
	hbox.to_y = hbox_angle.y
