extends Node

func register(codex):
	codex.set_subtitle("Flamestained Swordlord")
	codex.set_summary("""Colossus is a character intent on powering through enemy defenses and burning them alive through
his armor and flame mechanics. Use FORTITUDE to shrug off defenses and LORDFLAME to lay down powerful
fiery attacks.
""")

	codex.add_custom_text_tab(
"Fortitude",
"""[color=#686f99]FORTITUDE[/color] is a resource used by Colossus primarily to access ARMOR. It's slowly gained over time, but you can gain it actively by parrying.

[color=#686f99]USE[/color]
By spending 30 Fortitude, some of Colossus' specials can be given armor, which will go through most attacks except grabs and guardbreaks.

[color=#686f99]SUPER CLASH[/color]
If Colossus is hit while armored and the opponent blocks the attack, it will cause a SUPER CLASH.
This grants Colossus extra meter and does extra chip damage.

If the opponent hits you with a melee attack, they will be forced to block the attack. Projectiles won't do this.

[color=#888888]OPPONENT TIPS[/color]
- Grabs and guardbreaks will bypass armor.
- The armor will end once the hitboxes appear.
- When Colossus is below 30 Fortitude, he takes +50% damage and -1 extra block disadvantage to everything except +0 attacks.
""")

	codex.add_custom_text_tab(
"Lordflames",
"""[color=#ff8933]LORDFLAMES[/color] are a resource used by Colossus to access his fire-related moves. A maximum of 9 Lordflames can be held.
Landing a Burst Cancel immediately grants you 2 Lordflames.

[color=#ff8933]USE[/color]
With at least 1 Lordflame, you can access the FLAME stance through the UI, granting an onslaught of fire-related specials. These all require a different amount of flames to be used.
Most moves that use Lordflames also inflict FLAMESTAIN on hit and block.

[color=#888888]OPPONENT TIPS[/color]
- Naturally, locking down Colossus will prevent him from making use of his Lordflames.
""")

	codex.add_custom_text_tab(
"Flamestain",
"""[color=#ff8933]FLAMESTAIN[/color] is a resource and debuff inflicted by a lot of Colossus' fire-related specials.
Landing successful or blocked hits with these moves will grant Flamestain, with how much depending on the move.

[color=#ff8933]BURN[/color]
When the opponent takes or blocks a hit with at least 3 Flamestain, they will begin to [color=#ff8933]BURN[/color].
While they are burning, they will take damage every turn, and your block advantage is increased by 1 for attacks with 2+ block advantage.

[color=#ff8933]FIRE[/color]
Some attacks leave fire on the ground. If the opponent is inside this fire, they will take 1 damage every tick and 0.5 Flamestain every turn.

[color=#888888]OPPONENT TIPS[/color]
- Using Pushblock will instantly reduce Flamestain by 1.
- Burn damage cannot kill you.
- Landing a successful hit on Colossus immediately stops you from burning.

""")
