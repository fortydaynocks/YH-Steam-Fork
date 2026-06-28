extends "res://_NokDeoR/characters/deo/projectiles/DeoRStandState.gd"

var loops = [0, 0]
var chase_force = 0.25

func _enter():
	._enter()

func _exit():
	._exit()
	
	host.stop_sound("BlazingFists")

func _frame_0():
	loops[0] = 0

func _frame_1():
	host.play_sound("BlazingFists")
	
func _frame_10():
	self.face_opponent()
	
func _frame_40():
	host.stop_sound("BlazingFists")
	host.play_sound("BlazingFistsEnd")

func _tick():
	._tick()

	if current_tick >= 33 and loops[0] < loops[1]:
		loops[0] += 1
		self.current_tick = 10

	if current_tick < 35:
		var pos = Vector2(host.get_pos().x, host.get_pos().y)
		var opos = Vector2(host.get_owner().opponent.get_pos().x, host.get_owner().opponent.get_pos().y)
		opos.x -= (24 * host.get_facing_int())
		var vec = (opos - pos).normalized()
		
		host.apply_force(str(vec.x * chase_force), str(vec.y * chase_force))
