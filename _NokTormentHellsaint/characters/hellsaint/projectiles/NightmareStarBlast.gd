extends ObjectState

func _enter():
	._enter()
	
	if is_instance_valid($"%aura"): $"%aura".visible = false
	if is_instance_valid($"%aura2"): $"%aura2".visible = false
	if is_instance_valid($"%aura3"): $"%aura3".visible = false
	if is_instance_valid($"%aura4"): $"%aura4".visible = false
	if is_instance_valid($"%batscolored"): $"%batscolored".visible = false
	if is_instance_valid($"%batsblack"): $"%batsblack".visible = false

func _tick():
	._tick()
	
	if current_tick >= 10:
		host.disable()
