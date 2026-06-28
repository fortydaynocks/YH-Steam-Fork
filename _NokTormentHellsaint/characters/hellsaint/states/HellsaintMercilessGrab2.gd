extends ThrowState

export (PackedScene) var tp

func _enter():
	._enter()
	
	self.anim_name = "mercilessgrab2"
	host.start_invulnerability()

func _frame_14():
	host.apply_force_relative("8", "0")
	
func _frame_20():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost2")
	
func _frame_24():
	host.play_sound("CMN_005")
	
	host.apply_force_relative("-16", "0")
	
func _frame_31():
	self.anim_name = "devilkick"
	
	host.play_sound("introswing")
	
	if host.opponent.current_state().state_name in ["Burst", "OffensiveBurst", "DefensiveBurst"]:
		host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Hit1.tscn"), Vector2(0, -18))
		host.change_state("ThrowTech")
	
	host.reset_momentum()
	host.set_grounded(false)
	host.spawn_particle_effect_relative(tp, Vector2(0, -18))
	
	var opos = host.opponent.get_pos()
	var ovel = host.opponent.get_vel()
	var offset = Vector2(100, -24)
	
	host.set_pos(str((float(opos.x) + (offset.x * host.get_facing_int()))), str(float(opos.y) + offset.y))
	host.set_vel(ovel.x, ovel.y)
	host.apply_force_relative("-14", "6")
	host.set_facing(-host.get_facing_int())
	
func frame_32():
	host.spawn_particle_effect_relative(tp, Vector2(64, -18))
	
func _tick():
	._tick()
	
	if current_tick >= 40 and host.opponent.current_di.y == -100 and host.combo_count <= 1:
		host.change_state("comehere_yourend")

func update_sprite_frame():
	.update_sprite_frame()
	
	if current_tick > 30:
		host.sprite.frame = ((current_tick - 24) / ticks_per_frame)
