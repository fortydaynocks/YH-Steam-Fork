extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"
var can_apply_sadness = false
onready var rose = load("res://_NokRuffian/characters/ruffian/projectiles/RuffianRose_2.tscn")

var oh_dear_god = false

func _enter():
	._enter()
	oh_dear_god = false
	if data:
		if data.x == 69:
			oh_dear_god = true
	can_apply_sadness = host.combo_count <= 0

func _frame_44():
	host.gain_super_meter_raw(host.MAX_SUPER_METER)
	host.unlock_achievement("ACH_HUSTLE", true)
	var di = host.current_di


func _tick():
	._tick()
	var dir
	if data:
		dir = data

	var di = host.current_di
	if di.x == 69 and di.y == 69 and oh_dear_god == true:
		host.turn_everything_f1 = true
		host.Unlock("ohno", "S")
	if di.x == -69 and di.y == -69 and oh_dear_god == true:
		host.turn_everything_f1 = false

	if current_tick == 5 * ticks_per_frame:
		var fac = host.get_facing_int()
		
		var obj = host.spawn_object(rose, 16, -48, true, null, true)
		obj.set_grounded(false)
#		host.can_followup = true
		obj.set_facing(host.get_facing_int())
#		var dir = xy_to_dir(data.x, data.y, "5")
		obj.apply_force((dir.x * fac)/19, (dir.x/8) * -1)
#		obj.apply_force(dir.x, fixed.sub(dir.y, "4"))
