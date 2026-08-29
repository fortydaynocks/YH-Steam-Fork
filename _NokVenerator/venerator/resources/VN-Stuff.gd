extends Node

#	========================================================================== |
var host


#	========================================================================== |
func recursive_style_modulation(obj):
	if host.applied_style and host.applied_style.get("extra_color_2") and obj.get("modulate"):
		if obj.modulate.is_equal_approx(Color("f0b541")):
			obj.modulate = host.applied_style.extra_color_2
			
		if obj.modulate.is_equal_approx(Color("ffee83")):
			obj.modulate = host.applied_style.extra_color_2.lightened(0.5)
			
		if obj.modulate.is_equal_approx(Color("ff8933")):
			obj.modulate = host.applied_style.extra_color_2.darkened(0.5)
			
		#if host.applied_style.get("extra_color_2") and obj.modulate.is_equal_approx(Color("5300ff")):
			#obj.modulate = host.applied_style.extra_color_2
		
		for child in obj.get_children():
			recursive_style_modulation(child)
			
#	========================================================================== |
func _ready():
	host = owner

func _start():
	pass
	
func _tick():
	pass
