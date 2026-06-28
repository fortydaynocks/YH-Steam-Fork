extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_4():
	if not "Aerial" in self.editor_description:
		host.move_directly_relative("15", "0")
