extends DefaultFireball

func _frame_0():
	host.tag = "LodgedCleaver"
	$"%Spin".emitting = false
	
	host.hurtbox.width = 0
	host.hurtbox.height = 0
	
func _tick():
	._tick()
	
	var opos = host.get_opponent().get_pos()
	var offset = host.get_opponent().sprite.offset.y
	
	host.set_pos(str(opos.x), str(opos.y + offset))
	
	$"%Sprite".z_index = host.get_opponent().sprite.z_index + 1
