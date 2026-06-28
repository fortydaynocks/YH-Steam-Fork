extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var OTDhitlag
var hits
var dmg = 25

var execution = 0.1

onready var hbox_1kd = $"%Hitbox1KD"

func _enter():
	._enter()
	
	OTDhitlag = 12
	hits = 0
	
	if float(host.opponent.hp) / float(host.opponent.MAX_HEALTH) <= execution:
		host.play_sound("AK_1KDRiser")
	
func _frame_1():
	host.apply_force_relative("8", "0")
	
func _tick():
	._tick()
	
	host.start_invulnerability()
	host.colliding_with_opponent = false
	
	host.opponent.set_pos(host.get_pos().x, host.get_pos().y)
	host.opponent.set_vel(host.get_vel().x, host.get_vel().y)
	
	if host.opponent.hp < 50:
		hbox_1kd.damage = 0
		hbox_1kd.minimum_damage = 0
		
	else:
		hbox_1kd.damage = dmg
		hbox_1kd.minimum_damage = 0
	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if obj == host.opponent and "1KDeaths" in hitbox.misc_data:
		OTDhitlag -= 1; if OTDhitlag < 0: OTDhitlag == 0
		
		host.screen_bump(Vector2(0, 0), 6, 0.1)
		
		host.hitlag_ticks = OTDhitlag
		host.opponent.hitlag_ticks = OTDhitlag
		
		hits += 1
		
		if hits >= 32:
			host.change_state("1kdeaths3", {"Execute": float(host.opponent.hp) / float(host.opponent.MAX_HEALTH) <= execution})

func on_got_blocked():
	.on_got_blocked()
	
	hits += 2
	host.play_sound("1kDeaths-Blocked")
		
	if hits >= 32:
		host.change_state("1kdeaths3", {"Execute": false, "Blocked": true})
	
