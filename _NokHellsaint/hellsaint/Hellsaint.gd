extends Fighter

var buffers = {
	"harrow": false
}

var charname = "Torment"

var pain = {
	"value": 0,
	"max": 3,
	"mul": 4
}

#	========================================================================== >
func roman_numerals(num):
	var string = "0"
	var numerals = {
		1: "I",
		4: "IV", 5: "V",
		9: "IX", 10: "X",
		40: "XL", 50: "L",
		90: "XC", 100: "C",
		400: "CD", 500: "D",
		900: "CM", 1000: "M",
	}
	
	if num is int and num > 0:
		string = ""
		
		var antifreeze = 120
		while num > 0 and antifreeze > 0:
			antifreeze -= 1
			
			var biggest_num = 1
			for roman_key in numerals.keys():
				if num >= roman_key:
					biggest_num = roman_key
			
			string += numerals[biggest_num]
			num -= biggest_num
			
	return string

#	========================================================================== >
func global_hitlag(amount, force = false):
	.global_hitlag(amount, true)

func _process(delta):
	._process(delta)
	
	#	--	INFO DISPLAY
	$"%Info".visible = self.is_ghost
	$"%Info".bbcode_text = "[center]"
	
func tick():
	.tick()
	
	#print("> ", self.current_tick, " ", roman_numerals(self.current_tick))
