extends Node

func register(codex):
	codex.set_subtitle("Child of Ymia")
	codex.set_summary("""Snowdancer is a character focused on keeping the opponent moving and bombarding them with a swathe of projectiles.
	Her Glaciation and Snowflake resources ensure her opponent must always be keeping their attention on her, even from fullscreen."""
	)

	codex.add_custom_text_tab("Glaciation", """[color=#CBDBFC]Glaciation[/color] is a resource corresponding to the little bar above your head.
Information on it is also found below the character.
	
While the opponent is moving below the "Threshold" speed, the Glaciation gauge will slowly rise. Otherwise, it will slowly drop.
When Glaciation reaches its maximum value of 500, you gain access to [Immaculate Swansong], capable of freezing the opponent in their tracks.
<not yet implemented>
	
Tips:
-	While you are hitting the opponent, Glaciation cannot go down.
-	While the opponent is hitting you, Glaciation cannot go up.
-	If you have maximum Glaciation, it will not naturally go down unless you get hit.
	""")

	codex.add_custom_text_tab("Snowflakes", """[color=#CBDBFC]Snowflakes[/color] are Snowdancer's key resource, shown as little snowflakes below your character.
You can gain up to 4 Snowflakes.

Snowflakes are gained by using [Prayer].

Snowflakes can also be gained by Burst Cancelling, even on whiff. If you have less than 3 Snowflakes, it will set you to 3. If you already have 3, it will set you to 4.
	
	""")
	
	codex.add_custom_text_tab("Elegant Storm", """[color=#CBDBFC][Elegant Storm][/color] is a status that occurs whenever you possess 4 Snowflakes.
It provides some substantial buffs towards your moveset.

Using [Final Prayer] will activate [Elegant Storm] for 240 ticks. If you still have 4 Snowflakes, it will extend itself until you no longer have 4.
Using [Final Prayer] again during [Elegant Storm] will add 40 ticks to the timer.

Effects:
-	Cold Vortexes will not disappear until [Elegant Storm] runs out.
-	Cold Vortexes will affect all of your projectiles on-screen, effectively turning them all into homing projectiles.
	
	""")

	codex.add_custom_text_tab("Tips", """Here are some tips that might help as or against Snowdancer.
	
-	Icicles can be hit by the opponent with melee moves, offering them a free cancel.
-	Frozen Thorns will only activate while the opponent is grounded. Invulnerability or projectile invulnerability will also reset its duration.
	
	""")
