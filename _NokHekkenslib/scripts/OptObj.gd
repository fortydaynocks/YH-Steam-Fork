extends Node

var host
export (String) var type = null
var value_object
var value_name
var actual_value

func _ready():
	value_object = self.get_node("Value")
	
	if value_object is CheckBox:
		value_object.connect("pressed", self, "data_changed")
		
	elif value_object is SpinBox:
		value_object.connect("value_changed", self, "data_changed")
		
	elif value_object is LineEdit:
		value_object.connect("text_changed", self, "data_changed")

#	--
func data_changed(useless_parameter = null):
	if value_object is CheckBox:
		actual_value = value_object.pressed
		
	elif value_object is SpinBox:
		actual_value = value_object.value
		
	elif value_object is LineEdit:
		actual_value = value_object.text if value_object.text else " "
	
	if host:
		host.save()
