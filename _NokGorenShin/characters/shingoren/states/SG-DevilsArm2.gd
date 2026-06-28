extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

onready var hbox = $"%DevilsArm2Launch"

func _exit():
	._exit()
	
	host.opponent.can_update_sprite = true
	if host.get_camera(): host.release_camera_focus()
	
	if is_instance_valid(hbox):
		host.opponent.reset_momentum()
		host.opponent.set_grounded(true)
		
		var hbox_data = HitboxData.new(hbox)
		host.opponent.launched_by(hbox_data)
		
func _frame_0():
	host.start_invulnerability()
	host.opponent.start_invulnerability()
	
	host.opponent.reset_momentum()
	
	host.opponent.change_state("Grabbed")
	if host.opponent.get_camera(): host.opponent.grab_camera_focus()

func _frame_25():
	host.opponent.play_sound("Landing")
	host.opponent.rumble(1, 10)
	
	host.opponent.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(1, 0))
	host.opponent.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(-1, 0))
	
func _frame_50():
	host.opponent.play_sound("GroundBounce")
	host.opponent.rumble(2, 10)
	
	host.opponent.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
	
	if host.get_camera(): host.release_camera_focus()

func _tick():
	._tick()
	
	host.opponent.can_update_sprite = false
	host.opponent.sprite.frame = 999
	host.opponent.sprite.animation = "HurtGroundedHigh"
	
	if current_tick >= 25:
		host.opponent.sprite.animation = "Landing"
		
	if current_tick >= 50:
		host.opponent.sprite.animation = "Knockdown"
