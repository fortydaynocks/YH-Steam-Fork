extends PlayerExtra

onready var recline = $"%Recline"

#	--
func show_options():
	.show_options()

	if is_instance_valid(fighter):

		#	--	ITEM TOOLTIPS
		if is_instance_valid($"%Label"):
			$"%Label".hint_tooltip = "No items equipped..."
			
			var string = ""
			var strings2add = {}
			
			for item_key in fighter.items:
				var item = fighter.items[item_key]
				
				if item.Owned >= 1:
					strings2add[item.Name] = [item.Name, item.Owned, item.Tooltip]
				
			for obj_key in strings2add:
				var obj = strings2add[obj_key]
				
				string += str(obj[0]) + " x" + str(obj[1]) + ": " + str(obj[2]) + "\n"
			
			if string != "":
				$"%Label".hint_tooltip = string

		#	--	RECLINING
		recline.visible = false
		var found_chairs = 0

		for chair in fighter.objs_map.values():
			if is_instance_valid(chair):
				if chair.get_owner() == fighter and chair.disabled != true and chair.get("isgentlemanchair"):
					found_chairs += 1
					
		recline.visible = (found_chairs >= 1)

func get_extra():
	var extra = {
		"recline": recline.get_value() if recline.visible else 0,
	}
	return extra

func _on_Recline_data_changed():
	emit_signal("data_changed")
