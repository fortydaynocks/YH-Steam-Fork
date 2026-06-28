extends ObjectState
	
func _tick():
	._tick()
	
	var x = float(host.get_pos().x)
	
	if host.creator.objs_table.Motherspike and data.Gap:
		if current_tick == 0:
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x, host.ceiling_height, true, null, false)
			
		if current_tick == 5:
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x + data.Gap, host.ceiling_height, true, null, false)
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x - data.Gap, host.ceiling_height, true, null, false)
			
		if current_tick == 10:
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x + (data.Gap * 2), host.ceiling_height, true, null, false)
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x - (data.Gap * 2), host.ceiling_height, true, null, false)
			
		if current_tick == 15:
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x + (data.Gap * 3), host.ceiling_height, true, null, false)
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x - (data.Gap * 3), host.ceiling_height, true, null, false)
			
		if current_tick == 20:
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x + (data.Gap * 4), host.ceiling_height, true, null, false)
			host.creator.spawn_object(host.creator.objs_table.Motherspike, x - (data.Gap * 4), host.ceiling_height, true, null, false)
			
	if current_tick > 20:
		host.disable()
