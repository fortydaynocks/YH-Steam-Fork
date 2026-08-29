extends Node

func register(codex):
	codex.set_subtitle("Eradication Seraph")
	codex.set_summary(
"""Venerator is a character that hinges on her Blessings and Protostars.
Stocking up Blessings allows for the use of extra-powerful options, and Protostars are valuable setplay tools.

All of her UI elements are explained if you hover over them.
""")

	codex.add_custom_text_tab(
"Blessings",
"""[color=#f0b541]BLESSINGS[/color] are a resource that Venerator can gain to grant access to powerful options.
Proper management of Blessings is valuable to make the most out of your threat and damage, as her combo damage is normally rather low.

[color=#f0b541]GAIN[/color]
Blessings can be gained in the following ways:
	- Using [Angelica]
	- Landing [Testament]
	- Parrying (60f cooldown)
	- Grabbing (150f cooldown)

[color=#f0b541]USE[/color]
Blessings are (currently) used for three main moves:
	- [FLASHBEAM X] is a more powerful version of Flashbeam with much more range, spawning three stars on hit and block.
	- [CRUCIFIER] is a teleporting guardbreak that chains into a flurry of sword attacks.
	- [ERADICATION ORDER] is a divine beam from the sky that shreds through health, dealing fully unscaled damage.
	
All Blessing moves do much less damage if not landed in neutral.
	
[color=#888888]OPPONENT TIPS[/color]
- If a Venerator tries to get greedy with Angelica, don't let them do it!!

""")

	codex.add_custom_text_tab(
"Protostars",
"""[color=#f0b541]PROTOSTARS[/color] are stationary projectiles that Venerator can use in a few ways.

[color=#f0b541]USE[/color]
There are three main things that stars can do:
	- Layering a star on top of another turns it into a homing projectile.
	- [Path of Glory] is a fast beam that bounces between stars.
	- [CRUCIFIER] teleports to a star to perform a powerful sequence of attacks.
	
[color=#f0b541]OTHER USES[/color]
	- [FLASHBEAM X] can force a Path of Glory  to spawn if it passes over a star.
	
[color=#888888]OPPONENT TIPS[/color]
- Stars by themselves can't hit you, and you can destroy them with a simple punch.

""")


