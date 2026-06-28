extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_1():
	if data != null:
		if data in host.items:
			var item = host.items[data]
			
			if item.Owned + 1 <= item.Max:
				host.money -= item.Price
				item.Owned += 1
				
				host.play_sound("Buy1")
				host.play_sound("Buy2")
				host.screen_bump(Vector2(0, 0), 2, 0.1)
				
				host.spawn_particle_effect_relative(host.vfx_table.StoreBuy, Vector2(0, -18))
				var ptc_pos = Vector2(float(host.get_pos().x) + (16 * host.get_facing_int()), float(host.get_pos().y) - 38)
				var ptc = host._spawn_particle_effect(host.vfx_table.StoreBuyIcon, ptc_pos)
				ptc.get_node("Particle").texture = item.Icon
				
				host.update_item_icons()

func _frame_9():
	if host.combo_count >= 1:
		self.enable_interrupt()
