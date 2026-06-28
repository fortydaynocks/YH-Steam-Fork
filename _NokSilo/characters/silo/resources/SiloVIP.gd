extends Resource

export (SpriteFrames) var skin_sprites
export (SpriteFrames) var skin_fx

var host
var skin_enabled = true
var skin = null

var soundbytes_left = 0
var show_wings = false

#	------------------------------------------------------------------------------------------------
var skins = {
	"Sinestrosa": "Essence of the Witness",
	"SinWings": "Wings of Sin",
}

var VIPs = {
	"nok": [["Sinestrosa", "SinWings"], "Bringer of the First Annihilus"],
	"StrangerDanger": [["SinWings"], "First Known Silo"],
}

#	------------------------------------------------------------------------------------------------
var quotes = {
	"SinWings": {
		"_": [
			"'May the Wings guide you.'",
		],
	},
	
	"Intro": {
		"Torment": [
			"You despicable mongrel.",
			"Traitor. You deserve death.",
			"Insolent beast...",
			"I have choice words for you, Hellsaint.",
			"You are no longer my son.",
		],
		"Silo": [
			"Child... you are courageous.",
			"Have I seen you somewhere before?",
		],
		"Aimorrago": [
			"Welcome to this test, my liege.",
			"May we emerge stronger.",
			"In the glory of the crimson tides.",
			"I face you as a friend, my liege.",
		],
		"_": [
			"Your existence is forfeit.",
			"Drown beneath the red tides of blood.",
			"You beasts roam the world untamed.",
			"Prepare for the crimson baptism.",
			"Disgusting creatures deserve to be sanitized.",			
		],
	}
}
