extends ObjectState

var speed = 1
var pull_force = 0.3
var base_push_force = 0.5
var damage = 3

func _enter():
	._enter()
	
	host.play_sound("Breeze")
	host.play_sound("Breeze2")
	
func _exit():
	if is_instance_valid($"%Guide"):
		$"%Guide".visible = false

func _tick():
	._tick()
	
	if (current_tick >= anim_length - 1 and host.creator.get("elegant_storm") < 1) or host.creator.opponent.combo_count > 0:
		host.disable()
	
	#	--
	var pos = host.get_pos()
	var opos = host.creator.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, (opos.y - pos.y) - 18).normalized()
	
	host.move_directly(str(vec.x * speed), str(vec.y * speed))
	host.creator.opponent.apply_force(str((-vec.x) * pull_force), str((-vec.y) * pull_force) if host.creator.opponent.is_grounded() == false else "0")
	
	#	--
	for proj in host.creator.objs_map.values():
		if is_instance_valid(proj):
			if proj.creator == host.creator and proj.get("is_snowdancer_proj") == true and proj.disabled != true:
				if proj.get("ignore_cold_vortex") != true and (host.hurtbox.overlaps(proj.hurtbox) or host.creator.get("elegant_storm") > 0):
					var ppos = proj.get_pos()
					var pvec = Vector2(opos.x - ppos.x, (opos.y - ppos.y) - 18).normalized()
					
					var push_force = proj.get("cold_vortex_push_force") if proj.get("cold_vortex_push_force") else base_push_force
					
					proj.apply_force(str(pvec.x * push_force), str(pvec.y * push_force))
	
	#	--
	if is_instance_valid($"%Guide"):
		$"%Guide".visible = host.is_ghost

func detect(obj):
	if obj == host.creator.opponent and (not obj.current_state() is ParryState):
		obj.take_damage(damage)
		
		host.creator.increment_glac(1)
