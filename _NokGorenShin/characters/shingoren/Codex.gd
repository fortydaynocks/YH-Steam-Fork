extends Node

func setup_achievements(list):
	list.set_title("SG-WIN", "THE ROAD TO GLORY")
	list.set_desc("SG-WIN", "Win a match.")
	
	list.set_title("SG-1K-KILL", "THE RAGING DEMON")
	list.set_desc("SG-1K-KILL", "Kill an opponent with [One Thousand Deaths].")
	
	list.set_title("SG-REVERSE-TAUNT", "DEMON 'STEP'... GET IT?")
	list.set_desc("SG-REVERSE-TAUNT", "Land the reverse hitbox of [Taunt].")
	
	list.set_title("SG-HEIGHT", "DRAGON PUNCH")
	list.set_desc("SG-HEIGHT", "Successfully land [Height] or [Scorched Height] as a counterhit.")
	
	list.set_title("SG-DSTEP", "DUDE, GET OFF ME")
	list.set_desc("SG-DSTEP", "Pass over somebody twice with Demon Step.")
	
	list.set_title("SG-3CC", "EVERY COMBO IS PERSONALISED")
	list.set_desc("SG-3CC", "Land the melee hitbox of [Custom Combo] three times in one combo.")
	
	list.set_title("SG-AIR-INFERNO", "BURNING SKIES")
	list.set_desc("SG-AIR-INFERNO", "Land [Inferno March] in the air.")
	
	list.set_title("SG-ULT", "THE ULTIMATE SHOW OF POWER")
	list.set_desc("SG-ULT", "Succesfully land [One Thousand Deaths] while teleporting using [Demon Step].")
	
	list.set_title("SG-UBER", "THE UBER ONI")
	list.set_desc("SG-UBER", "Unlock all achievements and become the Uber Oni.")
	list.mark_secret("SG-UBER")

func modify_style_data(style, params):
	var codex = params.codex_library
	var char_path = params.char_path
	var achievements_list = codex.get_achievement_list(char_path)
	
	if achievements_list.is_array_unlocked(["SG-WIN", "SG-1K-KILL", "SG-REVERSE-TAUNT", "SG-HEIGHT", "SG-DSTEP", "SG-3CC", "SG-AIR-INFERNO", "SG-ULT"]):
		style.uber = true

func register(codex):
	codex.set_subtitle("Denizen of Hell")
	codex.set_summary(
"""Shin Goren is a character focused on tricky block pressure and combo routes to maximise his neutral and damage.
However, he takes 10% more damage - matches end quickly, with either you or your opponent dying fast.
""")

	codex.add_custom_text_tab(
"Firewalk",
"""[color=#ff8933]FIREWALK[/color] is an important toggle that can be activated to place down Firemarks and enter a unique stance.

[color=#ff8933]USE[/color]
Landing a successful or blocked hit with the Firewalk toggle pressed will perform a dash and place a Firemark near the opponent.
The direction of the dash is DI-controlled, and the Firemark will be placed in the opposite direction.
Doing this will also enter the Firewalk stance, granting you access to some even stronger specials.

[color=#ff8933]GAINING[/color]
GRANTS: Upon starting a combo, you will gain Grants equal to your maximum Firewalk usage. Hitting the opponent will grant you +1 Firewalk, if you can take it. Grants are lost when the combo ends.
FOCUS: Using Focus will grant you +1 use and +1 maximum use of Firewalk.
- The meter level of Focus = maximum Firewalk.
- The consumption of focus = maximum Firewalk - 1 (but it cannot go below 1).

[color=#888888]NOTES[/color]
- Only one Firemark can exist at a time.

[color=#888888]OPPONENT TIPS[/color]
- Firemarks can be destroyed with attacks - Shin Goren can't teleport to a destroyed mark. Better to get away from them, though!
""")

	codex.add_custom_text_tab(
"Firewarp",
"""[color=#e64539]FIREWARP[/color] is a second toggle accessible when a Firemark is placed.

[color=#e64539]USE[/color]
While using an attack, pressing the Firewarp toggle will teleport you to the mark's location once the hitboxes start scanning.
This is the case for most moves, but some will teleport earlier or later.

[color=#888888]OPPONENT TIPS[/color]
- Shin Goren cannot Firewarp a grab.
- Attack timings are NOT delayed from a teleport.
""")

	codex.add_custom_text_tab(
"Nerd Notes",
"""Some extra information...
- The mark placement of Demon Step can be offset with DI.


""")
