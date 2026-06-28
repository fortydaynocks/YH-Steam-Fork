extends Node

func register(codex):
	codex.set_subtitle("Unyielding Judge")
	codex.set_summary(
"""Betrayer is a character that revolves around the use of his summon, the Knight of Occlusion.
Successful plays with Betrayer involve placing his Judge Eyes in strategic positions to threaten his opponent.

All of his UI elements are explained if you hover over them.
""")

	codex.add_custom_text_tab(
"Judge Eyes",
"""[color=#80b5ff]JUDGE EYES[/color] are projectiles that Betrayer can place around the stage as a free action.

[color=#006aff]GAINING EYES[/color]
Judge Eyes can be gained by using one of Betrayer's five specials: [color=#80b5ff]Truth, Might, Order, Shadow[/color] and [color=#80b5ff]Acumen[/color].
You don't have to hit the move - as long as you use it.
Up to 2 Judge Eyes of each type can be carried at once.
[color=#888888]Note: you must reach at least frame 4 on the attack.[/color]

[color=#006aff]PLACEMENT[/color]
Spawning a Judge Eye costs one [color=#80b5ff]JUDGE POINT[/color], which can be gained by gaining meter or performing a full taunt.
Judge Eyes can be placed anywhere in a radius around Betrayer, with the type determined by the toggle pressed.
The eyes can be given velocity by moving the DI wheel, granting it extra space coverage.

[color=#006aff]USE[/color]
By using the super [color=#80b5ff][Occlusion][/color], the Knight of Occlusion can be summoned at an eye's location to perform an attack.
The attack is different depending on the type of eye, so remember where you should place them.

[color=#888888]OPPONENT TIPS[/color]
- Hitting a Judge Eye will destroy it, wasting a bit of Betrayer's resources. Abuse this if he places eyes in bad positions, but be careful - you don't get to free cancel the hit.
- Hitting Betrayer will immediately stop the Knight from attacking, so don't worry about your punish being interrupted.
- You cam hit the Knight with a melee attack to deflect it away from you. This might save you from a tricky situation. This will also let you free cancel the hit.

""")

	codex.add_custom_text_tab(
"Eye of Justice",
"""The [color=#80b5ff]Eye of Justice[/color] is a special kind of Judge Eye that can only be spawned after landing the super [color=#80b5ff][Blade of Justice][/color]. It lasts longer than regular Judge Eyes.

[color=#006aff]ABSOLUTE ASCENSION[/color]
Once an Eye of Justice has been placed onscreen, the Super [color=#80b5ff][Absolute Ascension][/color] can be used to enter the [color=#80b5ff]Ascension[/color] state.
While in this state, Judge Points are infinite, and using the move immediately maxes out all of your Judge Eyes.
Occlusion is also free.

""")

	codex.add_custom_text_tab(
"Bleed",
"""[color=#ad2f45]Bleed[/color] is a simple mechanic applied by [color=#ad2f45][Steal][/color] and [color=#ad2f45][Body Purge][/color].
While the opponent is bleeding, they will take small amounts of damage over time. This can't kill them.

If the opponent blocks an attack while bleeding, you will gain 1 extra block advantage and they will stop bleeding.
[color=#888888]Note: this will not apply to attacks that are +0 or less.[/color]
""")


