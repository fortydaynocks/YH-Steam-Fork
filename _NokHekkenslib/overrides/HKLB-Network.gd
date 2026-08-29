extends "res://cl_port/Network.gd"

func select_character(chr, style = null):
	var hklb = get_node_or_null("/root/Main/UILayer/Hekkenslib")
	
	if hklb:
		style = hklb.edit_style_data(chr, style)
	
	.select_character(chr, style)

