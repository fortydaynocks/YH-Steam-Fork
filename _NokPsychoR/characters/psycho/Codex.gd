extends Node

func register(codex):
	codex.set_subtitle("Mental Death")
	codex.set_summary(
"""Psycho is a monstrous assailant capable of doing massive amounts of damage
in a short time, when mediated correctly.
""")

	codex.add_custom_text_tab(
"Wounds and Scars",
"""[color=#FF0000]Wounds[/color] and [color=#FF8888]Scars[/color] are Psycho's
two important resources.

Scars are gained while using moves and attacking a blocking opponent.
Normals = 1 Scar
Special = 2 Scars
Supers = 3 Scars
The main purpose of Scars are to be transformed into Wounds.

Wounds are gained by converting Scars, landing successful hits or through
parries.
Wounds can be spent in many areas - most importantly, Haemorrhage.

Grace can be obtained by landing hits and making the opponent block during
Insanity.
Grace will be consumed instead of Scars to prevent your health from draining.

""")

	codex.add_custom_text_tab(
"Haemorrhage",
"""[color=#FF0000]Haemorrhage[/color] is an effect caused by striking an
opponent with certain moves while having at least 25 Wounds.
Haemorrhage can be triggered with [Arc of Disaster] or [Body Carving].
There are two variants of Haemorrhage:
	
[color=#FF0000]Haemorrhage - Damage[/color]
[color=#FF0000]Damage[/color] occurrs if you successfully strike an opponent
with at least 25 Wounds. The opponent will instantly sustain damage equivalent
to:

[color=#FF8888]0.75% remaining HP x number of Wounds[/color]

So, at full (15000) HP, the opponent will sustain [color=#FF8888]112.5 DMG x
the number of wounds[/color].
At 5000 HP, they will susain [color=#FF8888]37.5 DMG x the number of wounds[/color].

Haemorrhage - Damage instantly consumes all wounds.

[color=#FF0000]Haemorrhage - Bleed[/color]
[color=#FF0000]Bleed[/color] occurrs if the opponent blocks a Haemorrhage with
at least 25 Wounds.

Every tick, Psycho will consume a wound to inflict 1 damage and be put at +1
blockstun. This ends when all Wounds are consumed, Psycho is struck, or the
opponent parries anything.
""")

	codex.add_custom_text_tab(
"Stains",
"""
[color=#FF0000]Stains[/color] are stationary projectiles that can be placed
down and interacted with using the followup move, [Clean].

Stains can additionally be fed Wounds to change their properties.
""")

	codex.add_custom_text_tab(
"Insanity",
"""
[color=#FF0000]Insanity[/color] is a state where Psycho will begin to drain all
avaiable Scars into Wounds. If he is unable to do this, he loses a small amount
of HP.

""")

	codex.add_custom_text_tab(
"Other",
"""
Just a fun fact... it takes 134 Wounds to instakill someone. :^)

""")
