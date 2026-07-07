export (Dictionary) var objs_table
export (Dictionary) var vfx_table
export (Dictionary) var default_colors

var tweens = {}
var colors = {}

func init():
	for c in default_colors.keys():
		colors[c] = default_colors[c]
		
