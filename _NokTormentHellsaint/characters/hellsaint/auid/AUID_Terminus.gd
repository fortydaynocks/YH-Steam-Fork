extends ActionUIData

var tooltipC = """Choose a fittng theme to accompany the horror~

1. no theme
2. KROWW: HYSTERIA
3. DFKiryu - Bewitching
4. Honobono Daimakyo Kakenuke Jinja
"""
var tooltip = """Choose a fittng theme to accompany the horror.

1. no theme
2. Xtrullor - Vengeance
3. Varien - Blood Hunter
4. Xtrullor - Woe [VIP]
"""

func on_button_selected():
	if self.fighter and is_instance_valid($"%Direction"):
		if self.fighter.get_node("%Stuff").skin == "Camila":
			$"%Direction".hint_tooltip = tooltipC
			
		else:
			$"%Direction".hint_tooltip = tooltip
