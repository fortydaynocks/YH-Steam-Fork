extends Node

#	-------------------------------------------------------------------------- |
var VIPsssss = {
	"Hellsaint": [["Camila"], "<NO-TITLE>"],
	
	#	--
	"nok": [["Camila"], "[color=#ff0044]Developer & Death Bringer[/color]"],
	"WriterNat": [["Camila"], "¿Who am I?"],
	"Pres": [["Camila"], "The Seed of Doubt"],
	"CTM9001": [["Camila"], "Shredding Hearts into Rose Petals"],
	"Eminence": [["Camila"], "Demon Emperor"],
	"Lycan572": [["Camila"], "Trigger Happy Blood Fiend"],	#	<-- Dum Bnuy (unkown_anomaly)
	"samuraiarceus": [["Camila"], "Oni Born Under Sakura Blooms"],
	"MaoNao": [["Camila"], "The Will of WAH"],
	"Cherry": [["Camila"], "Ill-born Struggler"],
	"MuttDud": [["Camila"], "Supporter"],
	"Draedon": [["Camila"], "Architect of Steel and Stars"],
	"Diet_Bleach": [["Camila"], "Blood B*tch"],
	"Mana": [["Camila"], "Herrscher"],
	"Death": [["Camila"], "The One Waiting at the End"],
	"N.O.X": [["Camila"], "At the End of Everything, Only He Remains"],
	"soopernoob": [["Camila"], "The last Mofogyu in search of Earthend"],
	"MCHurt12": [["Camila"], "The Blue Dark Star"],
	"THExplosion24": [["Camila"], "Observer Forced Upon the Chaos"],
	"Script": [["Camila"], "Playful Pubstomper"],
	"Septite": [["Camila"], "Sat Upon the Throne of Brimstone"],
	"june_": [["Camila"], "Supporter"],
	"Shaygar": [["Camila"], "Seer of Sights"],
	"joshuahuff34": [["Camila"], "Supporter"],
	"Anna Mae": [["Camila"], "Supporter"],
	"inconsistent": [["Camila"], "Supporter"],
	"visualoverload": [["Camila"], "Fiend Risen Under the Roaring Moon"],
	"Mahoraga": [["Camila"], "With This Treasure I Summon..."],
	"Omegalord9000": [["Camila"], "Abyssal Sovereign"],
	"Rere3419": [["Camila"], "Happy Supporter"],
	"silicathefox": [["Camila"], "Frozen Supporter"],
	"HomestyleCrispeez": [["Camila"], "The Crispiest Bite"],
	"Korbus": [["Camila"], "First Revenant of Hengoku"],
	"Medi": [["Camila"], "Unbreakable Heart of Gold"],
	"jonesmd": [["Camila"], "Supporter"],
	"Dreadnoughtus": [["Camila"], "Scourge Of Rage"],
	"aridavis07": [["Camila"], "Supporter"],
	"odaciousL": [["Camila"], "The One and Lonely"],
	"Mikadzuki": [["Camila"], "Argalia"],
	"Dovahderpy": [["Camila"], "Spirit of Vengance"],
	"OneHitTalon": [["Camila"], "The God Wind Rabbit"],
	"Kirbymini": [["Camila"], "The Hollow's Abyss"],
	"scrimblo bingus": [["Camila"], "goober"],
	"GWAM": [["Camila"], "The Voices In The Void"],
	"TriGambit": [["Camila"], "Undying Soul"],
	"Angel Chuu": [["Camila"], "God of Creation"],
	"Mist": [["Camila"], "Kidnapper of Cherries"],
	"absolutely tutoumi": [["Camila"], "The Strongest Pubber"],
	"PixelTimesTwo": [["Camila"], "Certified Goofball"],
	"Trinity": [["Camila"], "Needs It"],
	"yakke1113": [["Camila"], "Fishy Business"],
	"Furious": [["Camila"], "The Dark Prince of Nothing"],
	"TheSolarInferno": [["Camila"], "The Collapsing Blight"],
	"MaxSmash09": [["Camila"], "Second Kindred Bloodfiend"],
	"system__shutdown": [["Camila"], "Tarnished Blood's Absolution"],
	"ANB1S": [["Camila"], "Overlord"],
	"ssjultrainstinct224": [["Camila"], "Supporter"],
	"BaffledFoxtail": [["Camila"], "Paragon"],
	"krankyz": [["Camila"], "God's Chosen Emperor"],
	"1majvvi1": [["Camila"], "jvvi"],
}
#	-------------------------------------------------------------------------- |
var tweens = {
	"emote_tween": create_tween(),
}

var host
var skin_enabled = true
var skin = null
var skin_aura = true

var music_access = false
var soundbytes_left = 0

var skins = {
	"Camila": "Mandate"
}

var quotes_tor = {
	"Intro": {
		"Torment": [
			"What a horrible night.",
		],
		
		#	--
		"Camila": [
			"Your desperation\n has surfaced.",
		],
		"Colossus": [
			"You must be disciplined, Avalon.",
		],
		"Skullmage": [
			"Don't cry after this is over.",
		],
		
		#	--
		"Aimorrago": [
			"You well and truly disgust me.",
		],
		"Revenant": [
			"Like father, like son.",
		],
		"Niflheim": [
			"A soul worth acknowledging.",
		],
		"Psycho": [
			"Mason. I can easily ruin you again.",
		],
		"Silo": [
			"You... why do you have its power?",
		],
		"Shin Goren": [
			"You're almost there.",
		],
		"Deo": [
			"And you call yourself a vampire?",
		],
		"Betrayer": [
			"Jurisdiction? Don't make me laugh.",
		],
		"Munanyou": [
			"It's a pleasure to be rid of you.",
		],
		"Reaper": [
			"How the mighty have fallen.",
		],
		"Haoma": [
			"Your services are redundant.",
		],
		"Venerator": [
			"You damned Angel.",
		],
		"_": [
			"What a miserable sight.",
			"Prepare... for agony.",
			"Get ready for the Rapture.",
			"I will send you to the depths.",
			"Resistance is futile.",
			"You should brace yourself.",
		],
	},
	"ComeHere": {
		"Torment": [
			"What a poor excuse of a clone.",
		],
		
		#	--
		"Camila": [
			"You do not own me.",
		],
		"Colossus": [
			"You'll never be free like that, Avalon.",
		],
		"Skullmage": [
			"Show me why I took you in.",
		],
		
		#	--
		"Aimorrago": [
			"Let me strip you of authority.",
		],
		"Revenant": [
			"Not very good at your job, aren't you?",
		],
		"Niflheim": [
			"Soulslayer. Show me you're worthy.",
		],
		"Psycho": [
			"Do you need a reminder?",
		],
		"Silo": [
			"Those hands bring me nothing but agony.",
		],
		"Shin Goren": [
			"Your flames aren't hot enough.",
		],
		"Deo": [
			"Useless, you say?",
		],
		"Betrayer": [
			"All of your beliefs are false.",
		],
		"Munanyou": [
			"Maybe you weren't as strong as I thought.",
		],
		"Reaper": [
			"Does the Reaper fear death?",
		],
		"Haoma": [
			"You're nothing without your defenses.",
		],
		"Venerator": [
			"You cannot even dream of victory.",
		],
		"_": [
			"I've had enough of you.",
			"Off you go.",
			"Let's use the open air.",
			"You think you stand a chance?",
			"Let us see the sights, shall we?",
		],
	},
	"KingsRegiment": { 
		"Torment":	[
			"And this is supposed to be the Hellsaint?",
		],
		
		#	--
		"Camila": [
			"Even after I elevated you to power...",
		],
		"Colossus": [
			"Have you learned nothing from me?",
		],
		"Skullmage": [
			"Is that soul all you're good for?",
		],
		
		#	--
		"Aimorrago": [
			"I will usurp you.",
		],
		"Revenant": [
			"I have a proper Rapture to show you.",
		],
		"Niflheim": [
			"I expected more from you.",
		],
		"Psycho": [
			"It will always end the same way, Mason.",
		],
		"Silo": [
			"Your potential bothers me.",
		],
		"Shin Goren": [
			"Your flames still aren't hot enough.",
		],
		"Deo": [
			"Useless, indeed.",
		],
		"Betrayer": [
			"Your persistence will be your death.",
		],
		"Munanyou": [
			"You've reached your limit, haven't you?",
		],
		"Reaper": [
			"No... the Reaper fears failure.",
		],
		"Haoma": [
			"Don't make me laugh.",
		],
			"Venerator": [
			"Just touching you makes me sick.",
		],
		"_": [
			"I appreciate the attempt.",
			"Who gave you that right?",
			"Scoundrel. Don't interrupt me.",
			"Rather amusing, don't you think?",
		],
	},
	"Terminus": {
		"_": [
			"I've seen enough.",
			"It's too late for you now.",
			"Prepare to greet the end.",
			"Oh, how tragic...",
			"Consider this my final gift.",
			"Death beckons. Go greet it.",
			"Witness the end of it all.",
		]
	},
}

var quotes_cml = {
	"Intro": {
		"Camila": [
			"You look... wonderful~",
		],
		
		#	--
		"Torment": [
			"Don't hold back\n on me, m'lord~",
		],
		"Colossus": [
			"Avalon! What's up with you today~?",
		],
		"Skullmage": [
			"Let's have fun, Marisa~",
		],
		
		#	--
		"Aimorrago": [
			"Well, that's worrying..",
		],
		"Niflheim": [
			"We're rather... *interested* in you~",
		],
		"Psycho": [
			"You poor soul...",
		],
		"Silo": [
			"Oh, dearie...",
		],
		"Betrayer": [
			"It's been so long, Yazarus~...",
		],
		"Munanyou": [
			"Wow... can I really do this...?",
		],
		"Zeiss": [
			"Why hello... 'President'~",
		],
		"Snowdancer": [
			"You'd look even more beautiful in red~",
		],
		"_": [
			"Why, hello there~",
			"Are you here to entice me?",
			"Please don't disappoint me~",
			"How interesting...",
			"This should be fun~",
			"Let's try a new kind of 'agony'...",
			"Let's play a little game I made~",
		],
	},
	"ComeHere": {		
		"Camila": [
			"Much too fragile, I'm afraid~",
		],
		
		#	--
		"Torment": [
			"Are you proud of me~?",
		],
		"Colossus": [
			"Are you letting me do this?",
		],
		"Skullmage": [
			"Let's get up close and personal~",
		],
		
		#	--
		"Aimorrago": [
			"Don't take it to heart, miss~",
		],
		"Niflheim": [
			"Try a little harder~",
		],
		"Psycho": [
			"No hard feelings~",
		],
		"Silo": [
			"Let's go on a trip, darling~",
		],
		"Betrayer": [
			"Prove your 'justice' to me~",
		],
		"Munanyou": [
			"I've always wanted to taste a god's blood~",
		],
		"Zeiss": [
			"I've always wanted to do this~",
		],
		"Snowdancer": [
			"How wonderful~",
		],
		"_": [
			"Come on, dance with me~",
			"Wanna see something cool?",
			"How disappointing~",
			"Close, but not quite~",
			"You're too rough on a lady~",
		],
	},
	"KingsRegiment": {
		"Camila": [
			"You lack my intelligence.",
		],
		
		#	--
		"Torment": [
			"Now you HAVE to acknowledge me~!",
		],
		"Colossus": [
			"Avalon, you can do better...",
		],
		"Skullmage": [
			"Come ooon, you're no fun~",
		],
		
		#	--
		"Aimorrago": [
			"Show me more, show me MORE!",
		],
		"Niflheim": [
			"Aww... is your flame dimming?",
		],
		"Psycho": [
			"Boss' orders, darling~",
		],
		"Silo": [
			"I'm sorry, darling, but no-can-do~",
		],
		"Betrayer": [
			"Your philosophy is too harsh~",
		],
		"Munanyou": [
			"Ooh, lookie~ I'm stronger than a goddess~",
		],
		"Zeiss": [
			"Hi, Zeiss~!",
		],
		"Snowdancer": [
			"No! Our dance isn't over~",
		],
		"_": [
			"Not good enough~",
			"What a letdown...",
			"I love it when you struggle~",
			"Too slow!",
			"'Oh, come on...' Ri~ght?",
		],
	},
	"Terminus": {
		"_": [
			"This might hurt a little...",
			"Welcome to the end of the road!",
			"Ooh, you're getting me excited~!.",
			"Now, the REAL test begins~",
			"Ahh, how it feels to be free~",
			"Let's see what your soul has to say~",
			"You really can't handle all this, darling~.",
			"Look into my eyes~",
		]
	},
}

#	-------------------------------------------------------------------------- |
func render_title(titles: Array, username = ""):
	if not titles: return
	
	if host.is_ghost == false:
		var title_text = "[center]"
		
		for found_title in titles:
			if found_title and found_title != "":
				if title_text != "[center]":
					title_text += " [" + found_title + "]\n"
				else:
					title_text += "[" + found_title + "]\n"
		
		title_text += username
		
		$"%Title".bbcode_text = title_text
		$"%Title".modulate = Color(1, 1, 1, 0.5)
		
		if tweens.has("Title"): tweens.Title.kill()
		else: tweens.Title = null
			
		tweens.Title = create_tween()
		tweens.Title.tween_property($"%Title", "modulate", Color(1, 1, 1, 0), 2)

func do_title(text):
	if host.is_ghost == false:
		$"%Title".bbcode_text = text
		$"%Title".modulate = Color(1, 1, 1, 0.5)
		
		if tweens.has("Title"): tweens.Title.kill()
		else: tweens.Title = null
			
		tweens.Title = create_tween()
		tweens.Title.tween_property($"%Title", "modulate", Color(1, 1, 1, 0), 2)
	
func choose_text(quote_choice = "Intro", quote_set = quotes_tor):
	if host:
		var o_charname = host.opponent.get("charname")
		if quote_choice == "_Custom":
			return host.randi_choice(quote_set)
		else:
			if o_charname and quote_set[quote_choice].get(o_charname):
				return host.randi_choice(quote_set[quote_choice][o_charname])
				
			else:
				return host.randi_choice(quote_set[quote_choice]._)
		
func do_text(quote = "...", extra_time = 0):
	if ReplayManager.resimulating == true: return
	
	if is_instance_valid($"%Emote"):
		if tweens.emote_tween: tweens.emote_tween.kill()
		
		$"%Emote".bbcode_text = "[center]" + quote
		$"%Emote".percent_visible = float(0)
		$"%Emote".modulate = Color(1, 0, 0.27, 1)
		
		if skin == "Camila": $"%Emote".modulate = Color(1, 0, 0, 1)
		
		var t = len($"%Emote".text) * 0.025
		soundbytes_left = round(len($"%Emote".text) * 0.5)
		
		tweens.emote_tween = create_tween()
		tweens.emote_tween.tween_property($"%Emote", "percent_visible", float(1), t)
		tweens.emote_tween.tween_property($"%Emote", "modulate", Color(1, 1, 1, 0), t + 0.25 + extra_time)
		
#	-------------------------------------------------------------------------- |
func _ready():
	host = owner
	music_access = true
	
	if is_instance_valid(Global.current_game):
		var style = Global.current_game.match_data.selected_styles[host.id]
		var titles = []
		var ca_title = "[color=#ff0000]Scandalous Eyes[/color]"
		var VIPs = {}
	
		if ResourceLoader.exists("res://_NokHekkenslib/VIP.tres"):
			VIPs = ResourceLoader.load("res://_NokHekkenslib/VIP.tres").list
			if VIPs.get("Hellsaint"): VIPs = VIPs.Hellsaint
		
		#	--	VIP
		var username = Network.pid_to_username(host.id)
		if username in VIPs:
			var owned_skins = VIPs[username][0]
			var title = VIPs[username][1]
			
			#	--	SKIN
			if skin_enabled == true and style and style.style_name:
				for available_skin in skins.keys():
					var required_style_name = skins[available_skin]
					
					if available_skin in owned_skins and (required_style_name in style.style_name or "Mandate" in style.style_name):
						skin = available_skin
						
				if title != "<NO-TITLE>":
					titles.append(title)
		
		if skin == "Camila":
			host.charname = "Camila"
			
			titles.append(ca_title)
		
		#	--	TITLE
		render_title(titles, username)
		
func _start():
	pass

func _tick():
	if soundbytes_left > 0 and host.current_tick % 1 == 0:
		host.play_sound("Soundbyte")
		soundbytes_left -= 1

func _process(d):
	pass
