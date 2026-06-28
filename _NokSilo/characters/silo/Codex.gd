extends Node

func register(codex):
	codex.set_subtitle("Wretched Soul")
	codex.set_summary("""Silo is a small but incredibly powerful character,
focused around area denial and modifying her moveset based on various conditions.

By growing Flowers and ganing Marks, she can add powerful tools to her moveset and viciously
pressure her opponents.

Tips:
-	Please do not use [Infectant] as a direct attack. It's very bad for that and has other purposes.
	""")

	codex.add_custom_text_tab("Stress", """Stress is a resource ranging from 0% to 100% that will change depending on Silo's actions.
Matches start with 50% Stress.

--
Above 80% Stress, Silo deals [color=#00FF00]15%[/color] more damage, but takes [color=#FF0000]15%[/color] more damage and gains [color=#FF0000]15%[/color] less meter.
Below 20% Stress, Silo takes [color=#00FF00]15%[/color] less damage and gains [color=#00FF00]15%[/color] more meter, but deals [color=#FF0000]15%[/color] less damage.

<things will happen at 0% stress and 100% stress. not yet designed or implemented>

--
	""")

	codex.add_custom_text_tab("Torture Marks", """ Landing [Palm of Life] or [Arc of Misfortune] will place a [color=#FF8888]Torture Mark[/color] on the opponent.
	
If a Torture Mark exists, Silo has access to additional powerful specials. Using any of these specials will remove the Mark.
They will also disappear by themselves after a while.
	
--
[color=#FF8888]Importantly, you can also create your own Torture Marks![/color]

To do this, you can place down a Flower and grab it using Surveyor. The flower must be ripe, however.

--
	""")
	
	codex.add_custom_text_tab("Eyes", """[color=#FF8888]Wretched Eyes[/color] (or just Eyes) are non-moving projectiles summoned with [Ocular Miracle] or [Sensation].
They will look towards the opponent, creating a visible line of sight that they will monitor.

If the eye gets too far from its target, it will despawn.

Eyes spawned with [Ocular Miracle] will copy the player's movement, but Eyes spawned with [Sensation] will remain still.

--
Eyes can be set to look at either the opponent, or the flower.

If the eye looks at an opponent, it can activate if any of their projectiles or [Infectant] passes through its sight.
If the eye looks at a Flower, it can activate if even the opponent themselves pass through its sight.AABB

When an Eye activates, it will disappear and summon a hand to attack the opponent.

--
Eyes cannot switch targets once they have been set.

--
	""")
	
	codex.add_custom_text_tab("Flowers", """[color=#FF8888]Bloodflowers[/color] (or just Flowers) are stationary projectiles that can be planted on the ground.
Flowers take a bit of time to grow, but once they are done they can be harvested, reducing Stress by a lot.
	
--
Eyes can look at Flowers, which grant them extra utility. They can activate if the opponent passes through them, which cannot happen normally.
Multiple Eyes can attach to one Flower.
	
--
Monoliths are created when a Surveyor hand grabs a Flower. Monoliths grant a Torture Mark that you can use for a short amount of time before disappearing.
	
--
Extra info:
Dread Wheels are attracted to Flowers, and will chase them instead of the opponent.
[Glorious Motherspike] plants a flower at its location of activation.
	
--
	""")
	codex.add_custom_text_tab("Other", """This page is for her old Codex info that I haven't rewritten. Extra info if you want it.
	
--
[color=#FF0000]Projectiles[/color]
[color=#FF8888]Portal Spikes[/color] are projectiles summoned from [Inside State]. They will strike at the opponent multiple times, spawning on their location.

[color=#FF8888]Withering Hands[/color] are outstretched arms that will spawn directly on top of the opponent and strike them, rendering them a large threat.
They are summoned from [color=#FF8888]Wretched Eyes[/color] or through the opponent contacting a [color=#FF8888]Motherspike[/color].

The [color=#FF8888]Dread Wheel[/color] is an elliptical, saw-shaped projectile that will chase after the opponent and embed itself into them, hitting multiple times.
It is summoned by the [Dread Wheel] move.
Dread Wheels are incredibly fast but do not have the most powerful homing, and one that misses its target will take a while to return.
	-	If any [color=#FF8888]Bloodflowers[/color] exist onscreen, Dread Wheels will instead chase after them.
		This can happen from any distance.
	-	Dread Wheels can be batted away by the opponent.

[color=#FF8888]Sustainers[/color] are small, circular projectiles that slowly drift towards the opponent, summoned with [Eternal Hunger].
If they come in contact with the opponent or an opponent projectile, they will attempt to eat it.
	-	If the target is the opponent, they will strike them and deal decent damage.
	-	If the target is an opponent projectile, the projectile is eaten and destroyed. This doesn't create a hitbox.

[color=#FF8888]Motherspikes[/color] are summoned only from [Glorious Motherspike]. 
If the opponent makes contact with them, they will summon a [color=#FF8888]Withering Hand[/color].

[color=#FF8888]Bloodflowers[/color] are small red roses that can be placed near Silo's feet. After a short time they will ripen, allowing them to be Harvesed.
Harvesting a Bloodflower greatly reduces [color=#FF0000]Stress[/color]. Bloodflowers also have unique interactions with certain projectiles.
	-	Bloodflowers can be cut down by the opponent, significantly increasing [color=#FF0000]Stress[/color].
	-	Bloodflowers will slowly replenish Silo's meter if the opponent is knocked down near them.
	-	If a [color=#FF8888]Wretched Eye[/color] connected to a [color=#FF8888]Bloodflower[/color] activates, the flower will become a [color=#FF8888]Monolith[/color].
	
[color=#FF8888]Monoliths[/color] are hand-shaped structures created after a [color=#FF8888]Surveyor[/color] grabs a ripe [color=#FF8888]Bloodflower[/color].
A Monolith grants a [color=#FF8888]Torture Mark[/color] that is available for 70 frames. Only one Monolith can exist at a time.

[color=#FF8888]Infectants[/color] are mouth-shaped projectiles that simply fly forwards and deal damage. But due to their physiology, they are able to manually activate [color=#FF8888]Wretched Eyes[/color].
	
--
	""")
