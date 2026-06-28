extends Node

func register(codex):
	codex.set_subtitle("The Distinguished")
	codex.set_summary("""Gentleman is a resource management character who relies on purchasing multiple Items to use ingame.
It is important to know what every item does and in what situations should they be bought.

Tips:
-	The three items at the top of [Stress Transaction] change every frame. Make sure to keep checking it!
-	The teacups from [Tea Throw] can be thrown on knockdowned opponents. They won't be hit, but they can still be burned by the splash.
-	It's good to invest in bullets! They can grant extra gun moves, and can consume ammo instead of consuming the gun.
	""")

	codex.add_custom_text_tab("Chairs", """Chairs are very expensive and comfortable, and can be sat in to modify your moveset.
	They can be placed down by using [Take a Seat].
	Chairs can be sat in while moving into them above a certain speed.
	You can adjust the provided "Recline" slider to change how early you sit in it.
	
	--
	Once sitting in a chair, you quickly gain meter over time. You can also use some of your Items.
	""")

	codex.add_custom_text_tab("Items", """Using [Stress Transaction], Gentleman can use Money to buy Items.
Money is obtained by dealing damage, or by gaining/losing a bar of meter. You start each game with $100.
	
Temporary items [randomly cycle in the shop]:
[color=#FEE761][Brass Knuckle][/color] - deal extra damage upon hitting the opponent.
[color=#FEE761][Money Shot][/color] - acts as ammo for Countermeasures. Increases his meter gain slightly for every one he has.
[color=#FEE761][Iron Shield][/color] - grants one hit of armor on Gentleman's normals.
[color=#FEE761][Agent License][/color] - allows Gentleman to summon Agents to assist in combat, done while sitting down.
[color=#FEE761][Pocket Knife][/color] - grants access to the [En Passant] series of attacks and a very damaging grab

Permanent items [always in the shop]:
[color=#FEE761][Tea Set][/color] - allows access to tea-based projectiles, which are all used while sitting down.
[color=#FEE761][Countermeaasures][/color] - allows access to gun-based moves. Can consume [color=#FEE761][Money Shot][/color]s instead to give more shots.
[color=#FEE761][Blackridge][/color] - allows Gentleman to ride his signature motorcycle, granting a plethora of moves.
	""")
