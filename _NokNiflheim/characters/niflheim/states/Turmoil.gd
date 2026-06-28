extends CharacterState

var cancounter = false
var recordedhp

func _enter():
	cancounter = true
	host.has_hyper_armor = true
	
func _exit():
	cancounter = false
	host.has_hyper_armor = false
	
func _frame_16():
	cancounter = false
	host.has_hyper_armor = false

func on_got_hit():
	if cancounter == true:
		cancounter = false

		host.opponent.end_invulnerability()
		host.opponent.hitlag_ticks = 20
		host.opponent.hitlag_applied = 20
		host.play_sound("MetalRingQuiet")
		queue_state_change("turmoilcounter")
