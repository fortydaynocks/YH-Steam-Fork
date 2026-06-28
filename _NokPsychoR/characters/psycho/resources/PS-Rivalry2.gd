extends "res://_NokPsychoR/characters/psycho/resources/PS-Rivalry.gd"

var quotes2 = {
	"Aimorrago": ["Imposter..."],
	"Sinestrosa": ["Bringer of Destruction..."],
	"Camila": ["Spawn of Asymollyon..."],
	"Munanyou": ["Lightning of Truth..."],
	"Torment": ["Traitor of Ichor..."],
	"Psycho": ["Madman of Vorskirk..."],
	"Silo": ["Eyes of the Savior..."],
	"Niflheim": ["Tooth of Amaterasu..."],
	"_": ["..."],
}

var rivals2 = """Torment"""
	
func _enter():
	._enter()
	
	if $"%Stuff".skin == "Aimorrago":
		self.rivals = rivals2
		self.quotes = quotes2
