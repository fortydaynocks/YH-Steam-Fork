extends Node


func register(codex):
	codex.set_subtitle("Hands of Mentenner")

	codex.set_summary("Let's fight, like gentlemen. (Or not)")


	codex.add_custom_text_tab("Weave", """
- Weave allows Ruffian to enter weave stance upon using a move, gaining access to most moves from Cover/EX Duck.
- Weave stance however, requires Ruffian to commit to an attack, being unable to block, use movement options, or anything of that sort until Ruffian uses an attack.
	- Cover and EX Duck do not have this weakness.
- Weave does however gain access to the normal variant of Quick Mix, which is a frame 3 hitbox.
	- Cover has a frame 4 variant""")

	codex.add_custom_text_tab("Corkscrew", """
- Corkscrew is available once Ruffian has a flower out from Parting Gift.
- Once Ruffian is close to the flower with the toggle enabled, he will instead use a version of Rusted Dust that hits "twice", as the second hit only really matters on block.
- Blocking
""")

	codex.add_custom_text_tab("Counterplay", """
- Ruffian has extremely strong and fast offense and good range for a boxer, but is extremely horizontal.
	- If Ruffian is either in the air or you are above/below him, he lacks suitable options to hit you.

- Ruffian's blockstrings are unpredictable, but hardly gapless, as Brash Hand doesn't have a melee hitbox and Parting Gift doesn't have any hitstun on the projectile.
	- Simply attack Ruffian if you think he's about to go for either of the two attacks.

- Weave stance (from Cover and the Weave toggle) looks scary, but simply attacking Ruffian is unironically the best choice, as Quick Mix doesn't combo, instead giving okizeme, even if Ruffian is a blockstring machine.
""")

	codex.moveset["drivethrough"].desc = "Changes in timing depending on which variant of Weave or Cover was used previously. Alt toggle when grounded moves Ruffian up when punching, and moves Ruffian down when punching when used while airborne."
	codex.moveset["friendlyhandshake"].desc = "Gives access to 3 followup supers. Launcher and The Magic Sequence combos regardless of position/DI, while Machinegrab combos less reliably."
	codex.moveset["rollingthunder"].desc = "This attack will repeatedly hit the opponent so long as Ruffian is not at the wall"
	codex.moveset["exduck"].desc = "If Ruffian is hit on specific frames of this move, both players become actionable and Ruffian is +1 block advantage, as if he blocked an attack."
	codex.moveset["Taunt"].desc = "Throws a rose that does hitstun. This projectile does nothing else, and has no similarities to the rose from Parting Gift."
	codex.moveset["brashhand"].desc = "Throw a punch that hits a desired spot, based on the UI attatched to the button. If the punch overlaps with a rose from Parting Gift, the punch will relocate in the opponent's direction, becoming slightly larger in the process"
	codex.moveset["brasherhand"].desc = "Throw a punch that hits a desired spot, based on the UI attatched to the button. If the punch overlaps with a rose from Parting Gift, the punch will relocate in the opponent's direction, becoming slightly larger in the process"
	codex.moveset["knuckleduster"].desc = "Slam your fist into the ground to send two shockwaves outward along the ground, one left and one right. If a shockwave hits a rose from Parting Gift, the shockwave will split into two smaller and slower shockwaves. These smaller shockwaves cannot be split further."

func setup_achievements(list):
	list.set_default_locked_icon("res://ui/ActionSelector/StateIcons/no_icon.png")

	list.define("Gentlemen", { "highlight_color": Color("#6e8696") })
	list.set_icon("Gentlemen", "res://_NokRuffian/characters/ruffian/icons/rficonjetupper.png")
	list.set_title("Gentlemen", "Fighting Like A Gentleman")
	list.set_desc("Gentlemen", "Hit the opponent with THE combo or use The Magic Sequence")
	list.mark_secret("Gentlemen")

	list.define("Knockout", { "highlight_color": Color("#6e8696") })
	list.set_icon("Knockout", "res://_NokRuffian/characters/ruffian/icons/rficonbrashhand.png")
	list.set_title("Knockout", "Knockout!")
	list.set_desc("Knockout", "Boxing is a refined form of combat. You however, lack the dignity to perfect it...")
	list.mark_secret("Knockout")

	list.define("ohno", { "highlight_color": Color("#6e8696") })
	list.set_icon("ohno", "res://_NokRuffian/characters/ruffian/icons/whathaveyoudone.png")
	list.set_title("ohno", "Dear God...")
	list.set_desc("ohno", "What have you done...")
	list.mark_secret("ohno")

func setup_options(options, params):
	# options.add_toggle("Internal name", "Visible option text", default value)
	options.add_label("""[color=#ff0000]NONE OF THESE OPTIONS DO ANYTHING WITHOUT BEING ON THE DONATION LIST.[/color]
You can get on the list via Nok's Ko-Fi""")
	options.add_toggle("voice", "Enable Voice", true)
	options.add_toggle("music", "Enable Special Song", true)
func modify_style_data(style, params):
	var codex_lib = params.codex_library
	var char_path = params.char_path
	var options_data = codex_lib.load_all_char_options(char_path)
	var achievements_list = codex_lib.get_achievement_list(char_path)
	style.voice = options_data.get("voice", true)
	style.music = options_data.get("music", true)
