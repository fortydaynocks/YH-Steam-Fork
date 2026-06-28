extends Fighter

#	--

var charname = "Niflheim"
var special = "false"
var idle = 1

var plume = true
var PLUME_CD_LENGTH = 100
var plumecd = PLUME_CD_LENGTH

var wave = true
var WAVE_CD_LENGTH = 80
var wavecd = WAVE_CD_LENGTH

var applyburn = false
var counttick = 0
var burntickstart = 0
var burntickend = 0
var burnduration = 0
var burndamage = 0

export (PackedScene) var burn_particle
var currentburnparticle = null

var currentplume = null

#	SPECIAL INTRO N STUFF ON INIT

var special_people = [
	"Skillshare",
	"Sharpi",
	"InklessBrush"
]

var extra_special_people = [
	"WriterNat",
	"nok",
	"Septite"
]


func is_special():
	var username = Network.pid_to_username(id)
	if username in extra_special_people:
		special = "extra_special"
	elif username in special_people:
		special = "special"
	else:
		special = "false"

func init(pos = null):
	#is_special()
	is_special()
	
	.init(pos)

#	EXTRA

func tick():
	.tick()
	
	melee_attack_combo_scaling_applied = false
		
	counttick += 1
	
	#	--	BURN DAMAGE
	
	if counttick < burntickend:
		
		opponent.hp -= burndamage
	
	#	--	HELL'S PLUME COOLDOWN
	
	if plumecd >= PLUME_CD_LENGTH:
		plume = true
	else:
		plume = false
		plumecd += 1
		
	#	--	WRATHFUL WAVE (GROUNDED) COOLDOWN
		
	if wavecd >= WAVE_CD_LENGTH:
		wave = true
	else:
		wave = false
		wavecd += 1

func start_burn(obj, duration: int, damage: int):
	if obj == opponent and (duration and damage):
		applyburn = true
		burntickstart = counttick
		burntickend = counttick + duration
		burnduration = duration
		burndamage = damage
